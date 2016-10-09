nixbot
======

Github bot for reviewing/testing pull requests with the help of [Hydra](http://nixos.org/hydra/)

Getting Started
---------------

- $ nix-shell

- $ generate-github-token

- $ vim development.ini

- $ pserve development.ini


Deployment
----------

Use the `nixbot` NixOS module in nixpkgs.

You need to set options for three repositories:
 - repo: the repository to be checked for PRs
 - prRepo: the repository used to create the branches in that hydra will test
 - hydraJobsetsRepo: the repository containing the jobset definitions. *nixbot* will push
   the branch names it will build to it. This repository needs to include the configs from
   jobset-repo-tmpl adapted to your needs.

The bot needs its own user account of which the token has to be set in `githubToken`,
see the service options for further customisation.

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


