import hmac
import json
import logging
import subprocess

import requests

log = logging.getLogger(__name__)

class HydraJobsets(object):
    def __init__(self, config):
        self.hydra_project = config.get('NIXBOT_HYDRA_PROJECT')
        self.repo = 'https://github.com/' + config.get('NIXBOT_PR_REPO')
        self.receiver = config.get('NIXBOT_RECEIVER_URL')
        self.key = config.get('NIXBOT_RECEIVER_KEY')
        self.nixexpr_path = config.get('NIXBOT_NIXEXPR_PATH')

    def _sendAuthenticatedRequest(self, url, data):
        headers = {
          'X-Nixbot-HMAC': hmac.new(self.key.encode('utf-8'), json.dumps(data).encode('utf-8')).hexdigest()
        }

        result = requests.post(url, json=data, headers=headers);
        result.raise_for_status()
        return result.json()

    def add(self, pr_id):
        return self._sendAuthenticatedRequest(f'{self.receiver}/jobset', {
            'project': self.hydra_project,
            'repo': self.repo,
            'jobset': f'pr-{pr_id}',
            'ref': f'pr-{pr_id}',
            'nixexpr_path': self.nixexpr_path,
        })['jobset_url']

    def remove(self, pr_id):
        return self._sendAuthenticatedRequest(f'{self.receiver}/jobset', {
            'project': self.hydra_project,
            'repo': self.repo,
            'jobset': f'pr-{pr_id}',
            'ref': f'pr-{pr_id}',
            'nixexpr_path': self.nixexpr_path,
            'hidden': True,
            'disabled': True,
        })['jobset_url']
