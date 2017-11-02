import hashlib
import hmac

from flask import abort, request, Blueprint

from .helper import gh_login
from .hydra_jobsets import HydraJobsets

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
    key = app.config.get('NIXBORG_GITHUB_SECRET').encode('utf-8')
    comp_signature = "sha1=" + hmac.new(key, request.get_data(), hashlib.sha1).hexdigest()
    if not hmac.compare_digest(signature.encode('utf-8'), comp_signature.encode('utf-8')):
        app.logger.error(f'HMAC of github webhook is incorrect')
        abort(403)

    event = request.headers['X-GitHub-Event']
    payload = request.get_json()
    bot_name = app.config.get('NIXBORG_BOT_NAME')

    repo = payload['repository']['full_name']
    configured_repo = app.config.get('NIXBORG_REPO')
    if repo != configured_repo:
        app.logger.error(f'Repository `{repo}` does not match configured `{configured_repo}`')
        abort(400)

    if event == "pull_request":
        pr_id = payload["pull_request"]["number"]
        if payload.get("action") in ["opened", "reopened", "edited"]:
            pr_info = (
                payload["pull_request"]["base"]["repo"]["owner"]["login"],
                payload["pull_request"]["base"]["repo"]["name"],
                pr_id
            )
            # TODO: evaluate and report statistics
            # TODO: merge next line with mention-bot
            # github_comment.delay(pr_info, HELP.format(bot_name=bot_name))
        if payload.get("action") in ["closed", "merged"]:
            jobsets = HydraJobsets(app.config)
            jobsets.remove(pr_id)
    elif event == "issue_comment":
        issue_commented.delay(payload)

    return "Ok"
