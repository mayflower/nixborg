with import <nixpkgs> {};

with python35Packages;

buildPythonPackage {
  name = "nixbot";
  src = ./.;

  propagatedBuildInputs = [ flask pygit2 github3_py waitress ];
}
