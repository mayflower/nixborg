from getpass import getpass

from flask import Flask, request

from github3 import authorize, login
from .hydra_jobsets import HydraJobsets
from .pr_merge import merge_push

HELP = """
Hi! I'm a bot that helps with reviewing and testing Nix code.

Commands:

- `@{bot_name} build` creates a new Hydra jobset and reports results
"""


app = Flask(__name__)
app.config.from_object('nixbot.default_settings')
app.config.from_envvar('NIXBOT_SETTINGS')


# def main(global_config, **settings):
#     callback = settings['nixbot.public_url'] + hook
#     print("Subscribing to repository {} at {}".format(repo.html_url, callback))
#     hooks = [h.config['url'] for h in repo.hooks()]
#     if not any(filter(lambda url: url == callback, hooks)):
#         repo.create_hook(
#             "web",
#             {
#                 "url": callback,
#                 "content_type": "json",
#             },
#             ["pull_request", "issue_comment"],
#         )


@app.route('/github-webhook', methods=['POST'])
def github_webhook():
    """
    https://developer.github.com/webhooks/

    TODO: use secret authenticate github using X-Hub-Signature
    """
    event = request.headers['X-GitHub-Event']
    payload = request.get_json()
    bot_name = app.config.get('NIXBOT_BOT_NAME')
    gh = login(token=app.config.get('NIXBOT_GITHUB_TOKEN'))
    repo = gh.repository(*app.config.get('NIXBOT_REPO').split('/'))

    if event == "pull_request":
        if payload.get("action") in ["opened", "reopened", "edited"]:
            print(
                payload["pull_request"]["base"]["repo"]["owner"]["login"],
                payload["pull_request"]["base"]["repo"]["name"],
                payload["pull_request"]["number"]
            )
            pr = gh.pull_request(
                payload["pull_request"]["base"]["repo"]["owner"]["login"],
                payload["pull_request"]["base"]["repo"]["name"],
                payload["pull_request"]["number"]
            )
            # TODO: evaluate and report statistics
            # TODO: merge next line with mention-bot
            pr.create_comment(HELP.format(bot_name=bot_name))
    elif event == "issue_comment":
        if payload.get("action") in ["created", "edited"]:
            comment = payload['comment']['body'].strip()
            bot_prefix = '@{} '.format(bot_name)
            # TODO: support merge
            if comment == (bot_prefix + "build"):
                # TODO: this should ignore issues
                pr = gh.pull_request(
                    payload["repository"]["owner"]["login"],
                    payload["repository"]["name"],
                    payload["issue"]["number"]
                )
                if repo.is_collaborator(payload["comment"]["user"]["login"]):
                    jobset = test_github_pr(
                        payload["issue"]["number"],
                        # TODO support specifying base
                        pr.base.ref
                    )
                    pr.create_comment("Jobset created at {}".format(jobset))
                else:
                    pr.create_comment("@{} is not a committer".format(payload["comment"]["user"]["login"]))

    return "Ok"


def test_github_pr(pr_id, base):
    jobsets = HydraJobsets(app.config)
    jobsets.add(pr_id)
    merge_push(pr_id, base, app.config)

    return "XXXurl"

def generate_github_token():
    user = ""
    password = ""
    scopes = ['user', 'repo', 'write:repo_hook']

    while not user:
        user = input('User: ')
    while not password:
        password = getpass('Password: ')

    auth = authorize(user, password, scopes, "testing", "http://example.com")
    print("Token: {}".format(auth.token))
