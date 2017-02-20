{ pkgs ? import <nixpkgs> {}
}:

let
  python = import ./requirements.nix { inherit pkgs; };
in python.overrideDerivation python.packages."nixbot" (old: {
  shellHook = old.shellHook + ''
    export LC_ALL=en_US.utf8
    export PATH=${pkgs.git}/bin:$PATH
    export NIXBOT_SETTINGS=${./development.cfg}
    export FLASK_DEBUG=1
    export FLASK_APP=nixbot
    export APP='python -m flask run --reload'
    $APP
  '';
})
