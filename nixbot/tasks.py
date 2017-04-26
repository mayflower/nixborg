import logging

from . import app, celery
from .helper import gh_login
from .hydra_jobsets import HydraJobsets
from .pr_merge import merge_push

log = logging.getLogger(__name__)


@celery.task()
def github_comment(args, pr_info, body):
    gh = gh_login(app.config.get('NIXBOT_GITHUB_TOKEN'))
    pr = gh.pull_request(*pr_info)
    log.info(f'Comment on PR {pr.number}: ' + body.format(*args))
    if app.config.get('NIXBOT_GITHUB_WRITE_COMMENTS'):
        pr.create_comment(body.format(*args))


@celery.task()
def test_github_pr(pr_info):
    gh = gh_login(app.config.get('NIXBOT_GITHUB_TOKEN'))
    pr = gh.pull_request(*pr_info)
    merge_push_task.delay(pr.number, pr.base.ref)
    (add_hydra_jobset.s(pr.number) |
        github_comment.s(pr_info, 'Jobset created at {}'))()


@celery.task
def add_hydra_jobset(pr_id):
    jobsets = HydraJobsets(app.config)
    jobsets.add(pr_id)

    return ['URL']


@celery.task
def merge_push_task(pr_id, base):
    merge_push(pr_id, base, app.config)
