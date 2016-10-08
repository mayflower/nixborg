import os.path
import pygit2
from pygit2 import Signature, UserPass, RemoteCallbacks


def merge_push(pr, settings):
    MAIN_REPO = "https://github.com/" + settings['nixbot.repo']
    PR_REPO = "https://github.com/" + settings['nixbot.pr_repo']
    REPO_PATH = settings['nixbot.repo_dir']

    user = settings['nixbot.bot_name']
    token = settings['nixbot.github_token']

    creds = RemoteCallbacks(UserPass(user, token))

    try:
        repo = pygit2.clone_repository(
            MAIN_REPO, os.path.join(REPO_PATH, "nixpkgs.git"), bare=False, callbacks=creds
        )
    except ValueError:
        repo = pygit2.Repository(os.path.join(REPO_PATH, "nixpkgs.git"))
        print('Repo already exists')

    repo.remotes.add_fetch('origin', "+refs/pull/*/head:refs/remotes/origin/pr/*")
    repo.remotes['origin'].fetch(callbacks=creds)

    try: repo.create_remote('pr', PR_REPO)
    except: pass

    repo.checkout('refs/heads/master')
    repo.reset(repo.lookup_reference('refs/remotes/origin/master').target, pygit2.GIT_RESET_HARD)
    master = repo.lookup_branch('master')

    origin_pr = repo.lookup_reference('refs/remotes/origin/pr/{}'.format(pr))
    repo.merge(origin_pr.target)

    author = Signature(settings['nixbot.bot_name'], 'bot@nixos.org')
    tree = repo.index.write_tree()
    repo.create_commit(
        master.name,
        author, author, 'Merge PR #{}'.format(pr),
        tree,
        [repo.head.target, origin_pr.target]
    )

    repo.state_cleanup()

    remote = repo.remotes['pr']
    pr_branch = 'pr-{}'.format(pr)
    repo.create_branch(pr_branch, repo.head.get_object(), True)
    repo.checkout('refs/heads/{}'.format(pr_branch))
    remote.push(['+refs/heads/{b}:refs/heads/{b}'.format(b=pr_branch)],
                callbacks=creds)

    repo.state_cleanup()

    return repo
