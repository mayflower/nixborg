import os.path
import pygit2
from pygit2 import Signature, UserPass, RemoteCallbacks
import logging

log = logging.getLogger(__name__)


def merge_push(pr, base, settings):
    MAIN_REPO = "https://github.com/" + settings['nixbot.repo']
    PR_REPO = "https://github.com/" + settings['nixbot.pr_repo']
    REPO_PATH = settings['nixbot.repo_dir']

    user = settings['nixbot.bot_name']
    token = settings['nixbot.github_token']

    creds = RemoteCallbacks(UserPass(user, token))

    path = os.path.join(REPO_PATH, "nixpkgs.git")

    try:
        log.info('Cloning {} to {}'.format(MAIN_REPO, path))
        repo = pygit2.clone_repository(
            MAIN_REPO, path, bare=False, callbacks=creds
        )
    except ValueError:
        repo = pygit2.Repository(path)

    log.info('Fetching base repository including PRs')
    repo.remotes.add_fetch('origin', "+refs/pull/*/head:refs/remotes/origin/pr/*")
    repo.remotes['origin'].fetch(callbacks=creds)

    try: repo.create_remote('pr', PR_REPO)
    except: pass

    log.info('Checking out and resetting to PR base branch')
    repo.checkout('refs/heads/{}'.format(base))
    repo.reset(repo.lookup_reference('refs/remotes/origin/{}'.format(base)).target, pygit2.GIT_RESET_HARD)
    base = repo.lookup_branch(base)

    log.info('Merging PR {} to base branch'.format(pr))
    origin_pr = repo.lookup_reference('refs/remotes/origin/pr/{}'.format(pr))
    repo.merge(origin_pr.target)

    log.info('Commiting merge')
    author = Signature(settings['nixbot.bot_name'], 'bot@nixos.org')
    tree = repo.index.write_tree()
    repo.create_commit(
        base.name,
        author, author, 'Merge PR #{}'.format(pr),
        tree,
        [repo.head.target, origin_pr.target]
    )

    repo.state_cleanup()

    remote = repo.remotes['pr']
    pr_branch = 'pr-{}'.format(pr)
    log.info('Pushing merge to {} branch at {}'.format(pr_branch, PR_REPO))
    repo.create_branch(pr_branch, repo.head.get_object(), True)
    repo.checkout('refs/heads/{}'.format(pr_branch))
    remote.push(['+refs/heads/{b}:refs/heads/{b}'.format(b=pr_branch)],
                callbacks=creds)

    repo.state_cleanup()

    return repo
