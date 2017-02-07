with import <nixpkgs> {};

with python35Packages;

buildPythonPackage {
  name = "nixbot";
  src = ./.;

  propagatedBuildInputs = [ flask pygit2 github3_py waitress glibcLocales ];
  shellHook = ''
    export LC_ALL=en_US.utf8
    NIXBOT_SETTINGS=${./development.cfg} FLASK_DEBUG=1 FLASK_APP=nixbot python -m flask run --reload
  '';
}
