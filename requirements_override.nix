{ pkgs, python }:

self: super: {

  "github3.py" = python.overrideDerivation super."github3.py" (old: {
    propagatedNativeBuildInputs = old.propagatedNativeBuildInputs ++ [ self."uritemplate" ];
    patchPhase = ''
      sed -i -e "s|uritemplate.py >= 0.2.0|uritemplate >= 0.2.0|" setup.py
    '';
  });

  mccabe = python.overrideDerivation super.mccabe (old: {
    propagatedNativeBuildInputs = old.propagatedNativeBuildInputs ++ [ self.pytest-runner ];
  });
  pytest-runner = python.overrideDerivation super.pytest-runner (old: {
    propagatedNativeBuildInputs = old.propagatedNativeBuildInputs ++ [ self.setuptools-scm ];
  });
}
