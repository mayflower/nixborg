from pathlib import Path
import logging
import subprocess

log = logging.getLogger(__name__)


def merge_push(pr, base, config):
    USER = config.get('NIXBOT_BOT_NAME')
    TOKEN = config.get('NIXBOT_GITHUB_TOKEN')
    MAIN_REPO = "https://github.com/" + config.get('NIXBOT_REPO')
    PR_REPO = f"https://{TOKEN}@github.com/{config.get('NIXBOT_PR_REPO')}"
    REPO_PATH = config.get('NIXBOT_REPO_DIR')

    path = Path(REPO_PATH, "nixpkgs.git")

    if not path.exists():
        log.info('Cloning {} to {}'.format(MAIN_REPO, path))
        path.parent.mkdir(mode=0o700, parents=True, exist_ok=True)
        logged_call(f'git clone {MAIN_REPO} {path}')

    GIT = f'git -C {path}'

    log.info('Fetching base repository including PRs')
    logged_call(f'{GIT} config --add remote.origin.fetch "+refs/pull/*/head:refs/remotes/origin/pr/*"')
    logged_call(f'{GIT} fetch origin')

    logged_call(f'{GIT} remote remove pr || true')
    logged_call(f'{GIT} remote add pr {PR_REPO}')

    log.info(f'Checking out PR {pr}')
    logged_call(f'{GIT} branch -f pr-{pr} origin/pr/{pr}')
    log.info(f'Rebasing PR on top of {base}')
    logged_call(f'{GIT} rebase origin/{base}')

    log.info(f'Pushing PR branch to PR repository')
    logged_call(f'{GIT} push -f pr HEAD:pr-{pr}')


def logged_call(args):
    try:
        subprocess.check_call(args, shell=True)
    except Exception as e:
        log.error(f'Failed to execute command: {args}')
        log.error(e)
        raise e
