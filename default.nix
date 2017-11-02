with import <nixpkgs> {};

pkgs.nixborg.server.overrideAttrs (oldAttrs: {
  src = ./.;

  shellHook = oldAttrs.shellHook + ''
    export LC_ALL=en_US.utf8
    export PATH=${pkgs.git}/bin:$PATH
    export NIXBORG_SETTINGS=${./development.cfg}
    export FLASK_DEBUG=1
    export FLASK_APP=nixborg
    export APP='python -m flask run --reload'
    export CELERY='celery -A nixborg.celery worker -E -l INFO'
    export FLOWER='celery -A nixborg.celery flower'
    echo 'Run $APP for the flask app, $CELERY for the celery worker'
    echo 'Run $FLOWER for the celery flower webmonitoring'
  '';
})
