import logging
import subprocess

log = logging.getLogger(__name__)

class HydraJobsets(object):
    def __init__(self, config):
        self.repo = "https://github.com/" + config.get('NIXBOT_REPO')

    def add(self, pr_id):
        subprocess.call(
            ['hydra-create-jobset', f'--url {self.repo}', f'--ref pr-{pr_id}', f'--pull-request {pr_id}'],
            stderr=subprocess.STDOUT
        )
