from pyramid.view import view_config


HELP = """
Hi! I'm a bot that helps with reviewing and testing Nix code.

Commands:

- `@{bot_name} build` creates a new Hydra jobset and reports results
"""


@view_config(
    route_name='github-webhook',
    renderer='json',
)
def github_webhook(request):
    """
    https://developer.github.com/webhooks/

    TODO: use secret authenticate github using X-Hub-Signature
    """
    event = request.headers['X-GitHub-Event']
    payload = request.json_body
    bot_name = request.registry.settings['nixbot.bot_name']

    if event == "pull_request":
        if payload.get("action") in ["opened", "reopened", "edited"]:
            pr = request.registry.gh.pull_request(
                payload["pull_request"]["base"]["repo"]["owner"]["login"],
                payload["pull_request"]["base"]["repo"]["name"],
                payload["pull_request"]["number"]
            )
            # TODO: evaluate and report statistics
            pr.create_comment(HELP.format(bot_name=bot_name))
    elif event == "issue_comment":
        if payload.get("action") in ["created", "edited"]:
            comment = payload['comment']['body'].strip()
            bot_prefix = '@{} '.format(bot_name)
            repo = request.registry.gh.Repository(request.registry.settings['nixbot.repo'])
            # TODO: support merge
            if comment == (bot_prefix + "build") and repo.is_collaborator(payload["comment"]["user"]["login"]):
                # TODO: this should ignore issues
                pr = request.registry.gh.pull_request(
                    payload["repository"]["owner"]["login"],
                    payload["repository"]["name"],
                    payload["issue"]["number"]
                )
                jobset = test_github_pr(
                    payload["issue"]["number"],
                    # TODO: support changing base
                    pr.repository[0],
                    pr.repository[1],
                    pr.head.user.login,
                    pr.head.ref,
                )
                pr.create_comment("Jobset created at {}".format(jobset))

    return {}


def test_github_pr(*a, **kw):
    print(a, kw)
    return "XXXurl"
