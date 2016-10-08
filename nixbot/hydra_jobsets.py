import json
import os.path
import pygit2
from pygit2 import RemoteCallbacks, UserPass, Signature
import logging

log = logging.getLogger(__name__)

class HydraJobsets(object):
    def __init__(self, settings):
        self.repo = "https://github.com/" + settings['nixbot.hydra_jobsets_repo']
        self.repo_path = settings['nixbot.repo_dir']
        self.user = settings['nixbot.bot_name']
        self.token = settings['nixbot.github_token']
        self.creds = RemoteCallbacks(UserPass(self.user, self.token))


    def add(self, pr_id):
        pr_name = 'pr-{}'.format(pr_id)
        log.info('Adding jobset {}'.format(pr_name))
        repo, prs = self._fetch_prs()
        if pr_name not in prs:
            prs.append(pr_name)
        self._save_prs(prs, repo, '{} added'.format(pr_name))

    def remove(self, pr_id):
        pr_name = 'pr-{}'.format(pr_id)
        log.info('Removing jobset {}'.format(pr_name))
        repo, prs = self._fetch_prs()
        if pr_name in prs:
            prs.remove(pr_name)
        self._save_prs(prs, repo, '{} removed'.format(pr_name))

    def _fetch_prs(self):
        path = os.path.join(self.repo_path, "hydra-prs.git")
        try:
            log.info('Cloning {} to {}'.format(self.repo, path))
            repo = pygit2.clone_repository(
                self.repo, path, bare=False, callbacks=self.creds
            )
        except ValueError:
            repo = pygit2.Repository(path)

        log.info('Fetching origin in {}'.format(path))
        repo.remotes['origin'].fetch(callbacks=self.creds)
        log.info('Checking out master in {}'.format(path))
        repo.checkout('refs/heads/master')
        log.info('Resetting hard to origin/master in {}'.format(path))
        repo.reset(repo.lookup_reference('refs/remotes/origin/master').target, pygit2.GIT_RESET_HARD)

        with open(os.path.join(path, 'prs.json')) as f:
            return (repo, json.load(f))

    def _save_prs(self, prs, repo, msg):
        path = os.path.join(self.repo_path, "hydra-prs.git")
        with open(os.path.join(path, 'prs.json'), 'w') as f:
            log.info('Writing to {}'.format(os.path.join(path, 'prs.json')))
            json.dump(prs, f)

        log.info('Staging all changes in {}'.format(path))
        repo.index.add_all()
        author = Signature(self.user, 'bot@nixos.org')
        tree = repo.index.write_tree()
        master = repo.lookup_branch('master')
        log.info('Commiting changes in {}'.format(path))
        repo.create_commit(
            master.name,
            author, author, msg,
            tree,
            [repo.head.target]
        )
        repo.state_cleanup()

        remote = repo.remotes[0]
        log.info('Pushing master in {}'.format(path))
        remote.push(['refs/heads/master'], callbacks=self.creds)

        repo.state_cleanup()

