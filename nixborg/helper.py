from github import Github

def gh_login(token):
    return Github(token)
