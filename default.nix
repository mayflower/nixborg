with (import (fetchTarball https://github.com/NixOS/nixpkgs/archive/cd45a2a1ac7e4ac3d700ada189c925845b218f91.tar.gz) {});

with python35Packages;

buildPythonPackage {
  name = "nixbot";
  src = ./.;

  propagatedBuildInputs = [ pyramid pygit2 github3_py waitress];
}
