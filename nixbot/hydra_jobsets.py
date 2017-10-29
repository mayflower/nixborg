import logging
import subprocess

log = logging.getLogger(__name__)

class HydraJobsets(object):
    def __init__(self, config):
        self.repo = "https://github.com/" + config.get('NIXBOT_REPO')

    def add(self, pr_id):
        subprocess.run(
            f'hydra-create-jobset nixos --trigger --url {self.repo} --ref pr-{pr_id} --pull-request {pr_id} --nixexpr-path nixos/release-small.nix',
            stderr=subprocess.STDOUT,
            check=True,
            shell=True
        )
