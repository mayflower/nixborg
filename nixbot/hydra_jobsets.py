import json
import os.path
import pygit2
from pygit2 import RemoteCallbacks, UserPass, Signature


class HydraJobsets(object):
    BRANCH = 'master'

    def __init__(self, settings):
        self.repo = "https://github.com/" + settings['nixbot.hydra_jobsets_repo']
        self.repo_path = settings['nixbot.repo_dir']
        self.user = settings['nixbot.bot_name']
        self.token = settings['nixbot.github_token']
        self.creds = RemoteCallbacks(UserPass(self.user, self.token))


    def add(self, pr_id):
        pr_name = 'pr-{}'.format(pr_id)
        repo, prs = self._fetch_prs()
        if pr_name not in prs:
            prs.append(pr_name)
        self._save_prs(prs, repo, '{} added'.format(pr_name))

    def remove(self, pr_id):
        pr_name = 'pr-{}'.format(pr_id)
        repo, prs = self._fetch_prs()
        if pr_name in prs:
            prs.remove(pr_name)
        self._save_prs(prs, repo, '{} removed'.format(pr_name))

    def _fetch_prs(self):
        path = os.path.join(self.repo_path, "hydra-prs.git")
        try:
            repo = pygit2.clone_repository(
                self.repo, path, bare=False, callbacks=self.creds
            )
        except ValueError:
            repo = pygit2.Repository(path)
            print('Repo already exists')

        repo.remotes['origin'].fetch(callbacks=self.creds)
        repo.checkout('refs/heads/master')
        repo.reset(repo.lookup_reference('refs/remotes/origin/master').target, pygit2.GIT_RESET_HARD)

        with open(os.path.join(path, 'prs.json')) as f:
            return (repo, json.load(f))

    def _save_prs(self, prs, repo, msg):
        path = os.path.join(self.repo_path, "hydra-prs.git")
        with open(os.path.join(path, 'prs.json'), 'w') as f:
            json.dump(prs, f)

        repo.index.add_all()
        author = Signature(self.user, 'bot@nixos.org')
        tree = repo.index.write_tree()
        master = repo.lookup_branch('master')
        repo.create_commit(
            master.name,
            author, author, msg,
            tree,
            [repo.head.target]
        )
        repo.state_cleanup()

        remote = repo.remotes[0]
        remote.push(['refs/heads/master'], callbacks=self.creds)

        repo.state_cleanup()

