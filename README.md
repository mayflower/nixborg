nixborg
======

Github bot for reviewing/testing pull requests with the help of [Hydra](http://nixos.org/hydra/)

Getting Started
---------------

- $ nix-shell
- $ $CELERY

- $ nix-shell
- $ $APP


Workflow
--------

- new PR appears
- maintainer tells bot to test the PR with `@nixborg build`
- PR branches is rebased upon its base (which can also be nixpkgs-channels branch)
- merged branch is pushed to nixpkgs/pr-XXX branch
- jobset definition is added to hydra declarative project in another git repository
- TODO: once built, report is commented on the PR
- TODO: optionally, merge the PR if there are no new failures, disable the jobset


