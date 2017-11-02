from datetime import datetime
import logging

from . import app, celery
from .helper import gh_login
from .hydra_jobsets import HydraJobsets
from .pr_merge import merge_push

log = logging.getLogger(__name__)


@celery.task()
def github_comment(args, number, body):
    gh = gh_login(app.config.get('NIXBORG_GITHUB_TOKEN'))
    repo = app.config.get('NIXBORG_REPO')
    pr = gh.get_repo(repo).get_pull(number)
    log.info(f'Comment on PR {pr.number}: ' + body.format(*args))
    if app.config.get('NIXBORG_GITHUB_WRITE_COMMENTS'):
        pr.create_issue_comment(body.format(*args))


@celery.task()
def test_github_pr(number, comment_time):
    gh = gh_login(app.config.get('NIXBORG_GITHUB_TOKEN'))
    repo = app.config.get('NIXBORG_REPO')
    pr = gh.get_repo(repo).get_pull(number)

    if datetime.strptime(comment_time, '%Y-%m-%dT%H:%M:%SZ') < pr.head.repo.pushed_at:
        raise(Exception('Comment is older than PR'))

    merge_push_task.delay(number, pr.head.sha, pr.base.ref)


@celery.task
def add_hydra_jobset(number):
    jobsets = HydraJobsets(app.config)
    return [jobsets.add(number)]


@celery.task
def merge_push_task(number, ref, base):
    merge_push(number, ref, base, app.config)
    (add_hydra_jobset.s(number) |
        github_comment.s(number, 'Jobset created at {}'))()


@celery.task
def issue_commented(payload):
    bot_name = app.config.get('NIXBORG_BOT_NAME')
    if payload.get("action") not in ["created", "edited"]:
        return

    comment = payload['comment']['body'].strip()
    if comment == (f'@{bot_name} build'):
        # TODO: this should ignore issues
        number = payload["issue"]["number"]
        gh = gh_login(app.config.get('NIXBORG_GITHUB_TOKEN'))
        repo = gh.get_repo(app.config.get('NIXBORG_REPO'))
        reviewer = payload["comment"]["user"]["login"]
        if repo.has_in_collaborators(reviewer) or reviewer in [ "globin", "fpletz", "grahamc" ]:
            test_github_pr.delay(number, payload['comment']['updated_at'])
        else:
            github_comment.delay((), number, f'@{payload["comment"]["user"]["login"]} is not a committer')
