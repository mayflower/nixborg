from flask import request, Blueprint

from .helper import gh_login

HELP = """
Hi! I'm a bot that helps with reviewing and testing Nix code.

Commands:

- `@{bot_name} build` creates a new Hydra jobset and reports results
"""

github_hook = Blueprint('github_hook', __name__)


@github_hook.route('/github-webhook', methods=['POST'])
def github_webhook():
    # https://developer.github.com/webhooks/
    # TODO: use secret authenticate github using X-Hub-Signature

    from . import app
    from .tasks import github_comment, test_github_pr

    event = request.headers['X-GitHub-Event']
    payload = request.get_json()
    bot_name = app.config.get('NIXBOT_BOT_NAME')
    gh = gh_login(app.config.get('NIXBOT_GITHUB_TOKEN'))
    repo = gh.repository(*app.config.get('NIXBOT_REPO').split('/'))

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
        if payload.get("action") in ["created", "edited"]:
            comment = payload['comment']['body'].strip()
            if comment == (f'@{bot_name} build'):
                # TODO: this should ignore issues
                pr_info = (
                    payload["repository"]["owner"]["login"],
                    payload["repository"]["name"],
                    payload["issue"]["number"]
                )
                if repo.is_collaborator(payload["comment"]["user"]["login"]):
                    test_github_pr.delay(pr_info)
                else:
                    github_comment.delay(pr_info, f'@{payload["comment"]["user"]["login"]} is not a committer')

    return "Ok"
