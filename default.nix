{ nixborgSrc ? { outPath = ./.; revCount = 1234; rev = "abcdef"; }
, nixpkgs ? <nixpkgs>
}:

let
  pkgs = import nixpkgs{};
in pkgs.callPackages ({ stdenv, python3, fetchFromGitHub, git }:
let
  server = python3.pkgs.buildPythonApplication rec {
    name = "nixborg-${version}";
    version = builtins.readFile ./version + "." + toString nixborgSrc.revCount + "." + nixborgSrc.rev;

    src = nixborgSrc.outPath;

    shellHook = ''
      export LC_ALL=en_US.utf8
      export PATH=${git}/bin:$PATH
      export NIXBORG_SETTINGS=$(pwd)/development.cfg
      export FLASK_DEBUG=1
      export FLASK_APP=nixborg
      export APP='python -m flask run --reload'
      export CELERY='celery -A nixborg.celery worker -E -l INFO'
      export FLOWER='celery -A nixborg.celery flower'
      echo 'Run $APP for the flask app, $CELERY for the celery worker'
      echo 'Run $FLOWER for the celery flower webmonitoring'
    '';

    propagatedBuildInputs = with python3.pkgs; [
      PyGithub flask flask_migrate flask_sqlalchemy celery redis requests
    ];

    doCheck = false;

    meta = with stdenv.lib; {
      description = "Github bot for reviewing/testing pull requests with the help of Hydra";
      maintainers = with maintainers; [ domenkozar fpletz globin ];
      license = licenses.asl20;
      homepage = https://github.com/mayflower/nixborg;
    };
  };
  receiver = stdenv.mkDerivation rec {
    name = "nixborg-receiver-${version}";
    inherit (server) src version meta;

    buildInputs = [ python3 ];
    dontBuild = true;

    installPhase = ''
      install -vD nixborg/receiver.py $out/bin/nixborg-receiver
    '';
  };
in { inherit server receiver; }) {}
