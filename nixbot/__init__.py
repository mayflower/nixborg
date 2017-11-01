import logging

from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

from .celery import make_celery
from .views import github_hook


app = Flask(__name__)
app.config.from_object('nixbot.default_settings')
app.config.from_envvar('NIXBOT_SETTINGS')
app.logger.setLevel(logging.INFO)
formatter = logging.Formatter(
    '{%(pathname)s:%(lineno)d} %(levelname)s - %(message)s',
)
handler = logging.StreamHandler()
handler.setFormatter(formatter)
handler.setLevel(logging.INFO)
app.logger.addHandler(handler)

db = SQLAlchemy(app)
migrate = Migrate(app, db)
celery = make_celery(app)

import nixbot.tasks
import nixbot.models

app.register_blueprint(github_hook)


@app.route('/')
def root():
    return ''

if __name__ == '__main__':
    app.run()


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


# def generate_github_token():
#     user = ""
#     password = ""
#     scopes = ['user', 'repo', 'write:repo_hook']

#     while not user:
#         user = input('User: ')
#     while not password:
#         password = getpass('Password: ')

#     auth = authorize(user, password, scopes, "testing", "http://example.com")
#     print("Token: {}".format(auth.token))
