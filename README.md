nixborg
======

Github bot for reviewing/testing pull requests with the help of [Hydra](http://nixos.org/hydra/)

Getting Started
---------------

```
$ nix-shell
$ $CELERY
```
```
$ nix-shell
$ $APP
```

Workflow
--------

- new PR appears
- maintainer tells bot to test the PR with `@nixborg build`
- PR branches is rebased upon its base (which can also be nixpkgs-channels branch)
- rebased branch is pushed to nixpkgs/pr-XXX branch
- HTTP request to nixbot-receiver script running on hydra
- receiver adds jobset definition to hydra via `hydra-update-jobset`
- TODO: once built, report is commented on the PR
- TODO: optionally, merge the PR if there are no new failures, disable the jobset
