Github bot helping with reviewing/testing Pull Requests on Hydra.

Workflow:

- new PR appears
- maintainer tells bot to test the PR with `@nixbot build`
- PR branches is merged against it's base (which can also be nixpkgs-channels branch)
- merged branch is pushed to nixpkgs-prs/pr-XXX branch
- jobset definition is added to hydra declarative project in another git repository
- once built, report is commented on the PR
- optionally, merge the PR if there are no new failures, disable the jobset


Getting Started
---------------

- $ virtualenv-3.5 .

- $ . bin/activate

- $ pip install -e .

- $ generate-github-token

- $ vim development.ini

- $ pserve development.ini
