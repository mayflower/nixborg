with import <nixpkgs> {};

with python36Packages;

buildPythonPackage {
  name = "nixbot";
  src = ./.;

  propagatedBuildInputs = [ flask github3_py waitress glibcLocales celery
    # (hydra.overrideDerivation (x: {
    #   patches = [
    #     ../hydra-prs/modules/hydra-master/create-jobset.patch
    #     (pkgs.fetchpatch {
    #       name = "faster-homepage-queries.patch";
    #       url = "https://github.com/grahamc/hydra/commit/4ba14370f8316f4533ca94f4994ba760dce18c68.patch";
    #       sha256 = "0bmy8sf71zsj00vs92v7x2vq3p5m1b3kixvppxs7lmbmcm6vw6sn";
    #     })
    #     (pkgs.fetchpatch {
    #       name = "faster-previous-build-step.patch";
    #       url = "https://github.com/grahamc/hydra/commit/b1c114312c28eb1152425848106999c057a24b31.patch";
    #       sha256 = "13jkn6cnbmv3glrzp7sg1743xglxzbycnfwa57dziixagh48qjad";
    #     })
    #   ];
    # }))
  ];
  shellHook = ''
    export LC_ALL=en_US.utf8
    export PATH=${git}/bin:$PATH
    export NIXBOT_SETTINGS=${./development.cfg}
    export FLASK_DEBUG=1
    export FLASK_APP=nixbot
    export APP='python -m flask run --reload'
    $APP
  '';
}
