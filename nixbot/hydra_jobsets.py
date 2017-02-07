import logging
import subprocess

log = logging.getLogger(__name__)

class HydraJobsets(object):
    def __init__(self, config):
        self.repo = "https://github.com/" + config.get('NIXBOT_HYDRA_JOBSETS_REPO')

    def add(self, pr_id):
        subprocess.call(
            ['hydra-create-jobset'#, --url {repo} --ref pr-{pr_id} --pull-request {pr_id}'.format(
                #repo=self.repo, pr_id=pr_id
            ],
            stderr=subprocess.STDOUT
        )
