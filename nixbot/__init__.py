from getpass import getpass

from pyramid.config import Configurator

from github3 import authorize, login


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    hook = '/github-webhook'
    config = Configurator(settings=settings)
    config.include('pyramid_chameleon')
    config.add_static_view('static', 'static', cache_max_age=3600)
    config.add_route('github-webhook', hook)
    config.registry.gh = gh = login(token=settings['nixbot.github_token'])
    config.registry.repo = repo = gh.repository(*settings['nixbot.repo'].split('/'))
    config.scan()

    # Subscribe for comments on startup
    callback = settings['nixbot.public_url'] + hook
    print("Subscribing to repository {} at {}".format(repo.html_url, callback))
    hooks = [h.config['url'] for h in repo.hooks()]
    if not any(filter(lambda url: url == callback, hooks)):
        repo.create_hook(
            "web",
            {
                "url": callback,
                "content_type": "json",
            },
            ["pull_request", "issue_comment"],
        )

    return config.make_wsgi_app()


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
