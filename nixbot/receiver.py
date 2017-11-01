#!/usr/bin/env python3

from http.server import BaseHTTPRequestHandler, HTTPServer
from shlex import quote
from urllib.parse import urlparse
import hmac
import json
import logging
import os
import subprocess


logging.basicConfig(
    level=logging.INFO,
    format='[%(asctime)s] {%(pathname)s:%(lineno)d} %(levelname)s - %(message)s',
    datefmt='%H:%M:%S'
)
logger = logging.getLogger(__name__)


def add_jobset(project, jobset, repo, ref, nixexpr_path, disabled=False, hidden=False):
    disabled_flag = '--disabled ' if disabled else ''
    hidden_flag = '--hidden' if hidden else ''
    result = subprocess.run(
        f'hydra-update-jobset {quote(project)} {quote(jobset)} --trigger --url {quote(repo)} --ref {quote(ref)}' +
        f'--nixexpr-path {quote(nixexpr_path)} {disabled_flag} {hidden_flag}',
        shell=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    if result.stderr:
        logger.error(result.stderr)
    result.check_returncode()

    return result.stdout


class HTTPForbidden(Exception):
    pass


class HydraJobsetManagerHandler(BaseHTTPRequestHandler):
    def request_setup(self):
        self.body = self.rfile.read(int(self.headers['Content-Length']))
        logger.info(self.body)
        self.json_body = self.parse_json_body()
        if not self.check_token():
            raise HTTPForbidden

    def check_token(self):
        return hmac.compare_digest(
            hmac.new(os.environ['NIXBOT_RECEIVER_KEY'].encode('utf-8'), self.body).hexdigest(),
            self.headers.get('X-Nixbot-HMAC')
        )

    def parse_json_body(self):
        return json.loads(self.body)

    def handle_jobset_creation(self):
        return add_jobset(**self.json_body)

    def do_POST(self):
        response = None
        try:
            self.request_setup()
            if urlparse(self.path).path == '/jobset':
                jobset_url = self.handle_jobset_creation()
                self.send_response(200)
                response = json.dumps({ 'jobset_url': jobset_url.decode('utf-8') }).encode('utf-8')
            else:
                self.send_response(204)
        except HTTPForbidden as e:
            logger.error(e)
            self.send_response(403)
        except Exception as e:
            logger.error(e)
            self.send_response(500)
        self.end_headers()
        self.wfile.write(response)

def main():
    server_address = (
        os.environ.get('NIXBOT_RECEIVER_ADDRESS', '127.0.0.1'),
        int(os.environ.get('NIXBOT_RECEIVER_PORT', 7000))
    )
    httpd = HTTPServer(server_address, HydraJobsetManagerHandler)
    httpd.serve_forever()

if __name__ == "__main__":
    main()
