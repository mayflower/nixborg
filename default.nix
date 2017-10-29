with import <nixpkgs> {};

pkgs.nixbot.overrideAttrs (oldAttrs: {
  src = ./.;

  shellHook = oldAttr.shellHook + ''
    export LC_ALL=en_US.utf8
    export PATH=${pkgs.git}/bin:$PATH
    export NIXBOT_SETTINGS=${./development.cfg}
    export FLASK_DEBUG=1
    export FLASK_APP=nixbot
    export APP='python -m flask run --reload'
    export CELERY='celery -A nixbot.celery worker -E -l INFO'
    export FLOWER='celery -A nixbot.celery flower'
    echo 'Run $APP for the flask app, $CELERY for the celery worker'
    echo 'Run $FLOWER for the celery flower webmonitoring'
  '';
})
