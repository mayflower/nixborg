from pathlib import Path
import logging
import subprocess

log = logging.getLogger(__name__)


def merge_push(pr, base, config):
    USER = config.get('NIXBOT_BOT_NAME')
    TOKEN = config.get('NIXBOT_GITHUB_TOKEN')
    REPO = f"https://{TOKEN}@github.com/" + config.get('NIXBOT_REPO')
    REPO_PATH = config.get('NIXBOT_REPO_DIR')

    path = Path(REPO_PATH, "nixpkgs.git")

    if not path.exists():
        log.info('Cloning {} to {}'.format(REPO, path))
        path.parent.mkdir(mode=0o700, parents=True, exist_ok=True)
        logged_call(f'git clone {REPO} {path}')

    GIT = f'git -C {path}'
    logged_call(f'{GIT} remote remove origin || true')
    logged_call(f'{GIT} remote add origin {REPO}')

    log.info('Fetching base repository including PRs')
    logged_call(f'{GIT} config --add remote.origin.fetch "+refs/pull/*/head:refs/remotes/origin/pr/*"')
    logged_call(f'{GIT} fetch origin')

    log.info(f'Checking out PR {pr}')
    logged_call(f'{GIT} branch -f pr-{pr} origin/pr/{pr}')
    log.info(f'Rebasing PR on top of {base}')
    logged_call(f'{GIT} rebase --abort || true')
    logged_call(f'{GIT} rebase origin/{base}')

    log.info(f'Pushing PR branch to PR repository')
    logged_call(f'{GIT} push -f origin HEAD:pr-{pr}')


def logged_call(args):
    try:
        subprocess.run(args, check=True, shell=True)
    except Exception as e:
        log.error(f'Failed to execute command: {args}')
        log.error(e)
        raise e
