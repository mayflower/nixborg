Gitub bot for reviewing/testing Pull Requests with the help of [Hydra](http://nixos.org/hydra/)

Getting Started
---------------

- $ nix-shell -p python3 -p libgit2 -p libffi

- $ pyvenv .

- $ . bin/activate

- $ pip install -e . --pre

- $ generate-github-token

- $ vim development.ini

- $ pserve development.ini

Deployment
----------

Use `nixbot` NixOS module in nixpkgs.

Features
--------

- build PRs given a jobset definition
- (soon) use github status api to reflect build status
- (soon) report build results compared to base branch
- (soon) print evaluation report upon new pull request


Workflow
--------

- new PR appears
- maintainer tells bot to test the PR with `@nixbot build`
- PR branches is merged against it's base (which can also be nixpkgs-channels branch)
- merged branch is pushed to nixpkgs-prs/pr-XXX branch
- jobset definition is added to hydra declarative project in another git repository
- once built, report is commented on the PR
- optionally, merge the PR if there are no new failures, disable the jobset


