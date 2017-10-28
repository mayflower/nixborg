from . import db

class PullRequest(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=False)
    mergeable = db.Column(db.Boolean)
    author = db.Column(db.String(128))
    title = db.Column(db.String(1024))
    state = db.Column(db.String(128))
    head = db.Column(db.String(1024))
    assignee = db.Column(db.String(128))
    priority = db.Column(db.Integer)
    approved_by = db.Column(db.String(128))
