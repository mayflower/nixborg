from pathlib import Path
import logging
import subprocess

log = logging.getLogger(__name__)


def merge_push(pr, ref, base, config):
    USER = config.get('NIXBORG_BOT_NAME')
    TOKEN = config.get('NIXBORG_GITHUB_TOKEN')
    REPO = f"https://github.com/" + config.get('NIXBORG_REPO')
    PR_REPO = f"https://{TOKEN}@github.com/" + config.get('NIXBORG_PR_REPO')
    REPO_PATH = config.get('NIXBORG_REPO_DIR')

    path = Path(REPO_PATH, "nixpkgs.git")

    if not path.exists():
        log.info('Cloning {} to {}'.format(REPO, path))
        path.parent.mkdir(mode=0o700, parents=True, exist_ok=True)
        logged_call(f'git clone {REPO} {path}')

    GIT = f'git -C {path}'
    logged_call(f'{GIT} remote add origin {REPO} || true')
    logged_call(f'{GIT} remote set-url origin {REPO}')
    logged_call(f'{GIT} remote add pr {PR_REPO} || true')
    logged_call(f'{GIT} remote set-url pr {PR_REPO}')

    log.info('Fetching base repository including PRs')
    logged_call(f'{GIT} config --add remote.origin.fetch "+refs/pull/*/head:refs/remotes/origin/pr/*"')
    logged_call(f'{GIT} fetch origin')

    log.info(f'Checking out PR {pr} at ref {ref}')
    logged_call(f'{GIT} branch -f pr-{pr} {ref}')
    log.info(f'Rebasing PR on top of {base}')
    logged_call(f'{GIT} rebase --abort || true')
    logged_call(f'{GIT} rebase origin/{base}')

    log.info(f'Pushing PR branch to PR repository')
    logged_call(f'{GIT} push -f pr HEAD:pr-{pr}')


def logged_call(args):
    try:
        subprocess.run(args, check=True, shell=True)
    except Exception as e:
        log.error(f'Failed to execute command: {args}')
        log.error(e)
        raise e
