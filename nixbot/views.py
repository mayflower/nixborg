import hashlib
import hmac
from flask import abort, request, Blueprint

from .helper import gh_login

HELP = """
Hi! I'm a bot that helps with reviewing and testing Nix code.

Commands:

- `@{bot_name} build` creates a new Hydra jobset and reports results
"""

github_hook = Blueprint('github_hook', __name__)


@github_hook.route('/github-webhook', methods=['POST'])
def github_webhook():
    from . import app
    from .tasks import github_comment, test_github_pr, issue_commented

    signature = request.headers['X-Hub-Signature']
    key = app.config.get('NIXBOT_GITHUB_SECRET').encode('utf-8')
    comp_signature = "sha1=" + hmac.new(key, request.get_data(), hashlib.sha1).hexdigest()
    if not hmac.compare_digest(signature.encode('utf-8'), comp_signature.encode('utf-8')):
        abort(403)

    event = request.headers['X-GitHub-Event']
    payload = request.get_json()
    bot_name = app.config.get('NIXBOT_BOT_NAME')

    if event == "pull_request":
        if payload.get("action") in ["opened", "reopened", "edited"]:
            pr_info = (
                payload["pull_request"]["base"]["repo"]["owner"]["login"],
                payload["pull_request"]["base"]["repo"]["name"],
                payload["pull_request"]["number"]
            )
            # TODO: evaluate and report statistics
            # TODO: merge next line with mention-bot
            github_comment.delay(pr_info, HELP.format(bot_name=bot_name))
    elif event == "issue_comment":
        issue_commented.delay(payload)

    return "Ok"
