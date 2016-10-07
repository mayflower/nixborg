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
    config.registry.gh = login(token=settings['nixbot.github_token'])
    config.scan()

    # Subscribe for comments on startup
    # using https://developer.github.com/v3/repos/hooks/#subscribing
    callback = settings['nixbot.public_url'] + hook
    for repo in settings['nixbot.repos'].split():
        print("Subscribing to repository {} at {}".format(repo, callback))
        config.registry.gh.pubsubhubbub(
            "subscribe",
            repo + "/events/pull_request",
            callback,
            settings['nixbot.github_secret']
        )
        config.registry.gh.pubsubhubbub(
            "subscribe",
            repo + "/events/pull_request_review_comment",
            callback,
            settings['nixbot.github_secret']
        )

    return config.make_wsgi_app()


def generate_github_token():
    user = ""
    password = ""
    scopes = ['user', 'repo']

    while not user:
        user = input('User: ')
    while not password:
        password = getpass('Password: ')

    auth = authorize(user, password, scopes, "testing", "http://example.com")
    print("Token: {}".format(auth.token))
