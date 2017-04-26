# generated using pypi2nix tool (version: 1.8.0)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -e ./[testing]#egg=nixbot -V 3.6 -v
#

{ pkgs ? import <nixpkgs> {}
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python36;
  };

  commonBuildInputs = [];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreter = pythonPackages.buildPythonPackage {
        name = "python36-interpreter";
        buildInputs = [ makeWrapper ] ++ (builtins.attrValues pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter}               $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "               (builtins.attrValues pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -f $prog ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };
    in {
      __old = pythonPackages;
      inherit interpreter;
      mkDerivation = pythonPackages.buildPythonPackage;
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (drv.drvAttrs // f drv.drvAttrs);
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {

    "Babel" = python.mkDerivation {
      name = "Babel-2.4.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/92/22/643f3b75f75e0220c5ef9f5b72b619ccffe9266170143a4821d4885198de/Babel-2.4.0.tar.gz"; sha256 = "8c98f5e5f8f5f088571f2c6bd88d530e331cbbcb95a7311a0db69d3dca7ec563"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pytz"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "Internationalization utilities";
      };
    };



    "Flask" = python.mkDerivation {
      name = "Flask-0.12.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/24/6e/11b9c57e46f276a8a8dfda85a2fa7ada62b0463b68693616c7ab5df356fa/Flask-0.12.1.tar.gz"; sha256 = "9dce4b6bfbb5b062181d3f7da8f727ff70c1156cbb4024351eafd426deb5fb88"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Jinja2"
      self."Werkzeug"
      self."click"
      self."itsdangerous"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "A microframework based on Werkzeug, Jinja2 and good intentions";
      };
    };



    "Jinja2" = python.mkDerivation {
      name = "Jinja2-2.9.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/90/61/f820ff0076a2599dd39406dcb858ecb239438c02ce706c8e91131ab9c7f1/Jinja2-2.9.6.tar.gz"; sha256 = "ddaa01a212cd6d641401cb01b605f4a4d9f37bfc93043d7f760ec70fb99ff9ff"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Babel"
      self."MarkupSafe"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "A small but fast and easy to use stand-alone template engine written in pure python.";
      };
    };



    "MarkupSafe" = python.mkDerivation {
      name = "MarkupSafe-1.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4d/de/32d741db316d8fdb7680822dd37001ef7a448255de9699ab4bfcbdf4172b/MarkupSafe-1.0.tar.gz"; sha256 = "a6be69091dac236ea9c6bc7d012beab42010fa914c459791d627dad4910eb665"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "Implements a XML/HTML/XHTML Markup safe string for Python";
      };
    };



    "Werkzeug" = python.mkDerivation {
      name = "Werkzeug-0.12.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ab/65/d3f1edd1109cb1beb6b82f4139addad482df5b5ea113bdc98242383bf402/Werkzeug-0.12.1.tar.gz"; sha256 = "6716830febe9808bb7521fd26db3b398450cbed0886b2b4bea678b87340f534e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "The Swiss Army knife of Python web development";
      };
    };



    "amqp" = python.mkDerivation {
      name = "amqp-2.1.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/23/39/06bb8bd31e78962675f696498f7821f5dbd11aa0919c5a811d83a0e02609/amqp-2.1.4.tar.gz"; sha256 = "1378cc14afeb6c2850404f322d03dec0082d11d04bdcb0360e1b10d4e6e77ef9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."vine"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "Low-level AMQP client for Python (fork of amqplib).";
      };
    };



    "astroid" = python.mkDerivation {
      name = "astroid-1.5.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/69/8b/711d5475de8784ecf8d9e208b3f4cbbeab5ca7d9e6592ebb359173bc5f26/astroid-1.5.2.tar.gz"; sha256 = "271f1c9ad6519a5dde2a7f0c9b62c2923b55e16569bdd888f9f9055cc5be37ed"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."lazy-object-proxy"
      self."six"
      self."wrapt"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.lgpl3;
        description = "A abstract syntax tree for Python with inference support.";
      };
    };



    "billiard" = python.mkDerivation {
      name = "billiard-3.5.0.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e6/b8/6e6750f21309c21ea267834d5e76b89ce64a9ddf38fa4161fd6fb32ffc3b/billiard-3.5.0.2.tar.gz"; sha256 = "3eb01a8fe44116aa6d63d2010515ef1526e40caee5f766f75b2d28393332dcaa"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "Python multiprocessing fork with improvements and bugfixes";
      };
    };



    "celery" = python.mkDerivation {
      name = "celery-4.0.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b2/b7/888565f3e955473247aef86174db5121d16de6661b69bd8f3d10aff574f6/celery-4.0.2.tar.gz"; sha256 = "e3d5a6c56a73ff8f2ddd4d06dc37f4c2afe4bb4da7928b884d0725ea865ef54d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."billiard"
      self."kombu"
      self."pytz"
      self."redis"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "Distributed Task Queue.";
      };
    };



    "click" = python.mkDerivation {
      name = "click-6.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/95/d9/c3336b6b5711c3ab9d1d3a80f1a3e2afeb9d8c02a7166462f6cc96570897/click-6.7.tar.gz"; sha256 = "f15516df478d5a56180fbf80e68f206010e6d160fc39fa508b65e035fd75130b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "A simple wrapper around optparse for powerful command line utilities.";
      };
    };



    "flower" = python.mkDerivation {
      name = "flower-0.9.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b4/94/39eff3d8727c03865e6693911a1d84295959238d932603d4dbf2069fe5c9/flower-0.9.1.tar.gz"; sha256 = "bdd926b731e8024779a5373fa33bff4a30e2a2ae6cf3a591beb83fbde3dc352f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Babel"
      self."celery"
      self."pytz"
      self."tornado"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "Celery Flower";
      };
    };



    "github3.py" = python.mkDerivation {
      name = "github3.py-0.9.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c7/44/69354d18979a0f30b09ec391294798e96aa578665f3d1fea4377759e3b56/github3.py-0.9.6.tar.gz"; sha256 = "b831db85d7ff4a99d6f4e8368918095afeea10f0ec50798f9a937c830ab41dc5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "Redistribution and use in source and binary forms, with or without ";
        description = "Python wrapper for the GitHub API(http://developer.github.com/v3)";
      };
    };



    "isort" = python.mkDerivation {
      name = "isort-4.2.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/70/65/49f66364f4ac551ec414e88537b02be439d1d9ea7e1fdd6d526fb8796bf9/isort-4.2.5.tar.gz"; sha256 = "56b20044f43cf6e6783fe95d054e754acca52dd43fbe9277c1bdff835537ea5c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "A Python utility / library to sort Python imports.";
      };
    };



    "itsdangerous" = python.mkDerivation {
      name = "itsdangerous-0.24";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/dc/b4/a60bcdba945c00f6d608d8975131ab3f25b22f2bcfe1dab221165194b2d4/itsdangerous-0.24.tar.gz"; sha256 = "cbb3fcf8d3e33df861709ecaf89d9e6629cff0a217bc2848f1b41cd30d360519"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "Various helpers to pass trusted data to untrusted environments and back.";
      };
    };



    "kombu" = python.mkDerivation {
      name = "kombu-4.0.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c7/76/58c655a80bf08b703478ce673ed4e3029297105951863b73030d45b06b42/kombu-4.0.2.tar.gz"; sha256 = "d0fc6f2a36610a308f838db4b832dad79a681b516ac1d1a1f9d42edb58cc11a2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."amqp"
      self."redis"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "Messaging library for Python.";
      };
    };



    "lazy-object-proxy" = python.mkDerivation {
      name = "lazy-object-proxy-1.2.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/65/63/b6061968b0f3c7c52887456dfccbd07bec2303296911757d8c1cc228afe6/lazy-object-proxy-1.2.2.tar.gz"; sha256 = "ddd4cf1c74279c349cb7b9c54a2efa5105854f57de5f2d35829ee93631564268"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "A fast and thorough lazy object proxy.";
      };
    };



    "mccabe" = python.mkDerivation {
      name = "mccabe-0.6.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/06/18/fa675aa501e11d6d6ca0ae73a101b2f3571a565e0f7d38e062eec18a91ee/mccabe-0.6.1.tar.gz"; sha256 = "dd8d182285a0fe56bace7f45b5e7d1a6ebcbf524e8f3bd87eb0f125271b8831f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "McCabe checker, plugin for flake8";
      };
    };



    "mypy" = python.mkDerivation {
      name = "mypy-0.501";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/2e/e6/80ab4dba528d295341e46b0ca1ea62024d491c14d5eaa56545cf2b7b7da2/mypy-0.501.tar.gz"; sha256 = "1098ba0bc55b4f6cebdf35f1303be31107f2ae5a753f9aec28aaff2d701b8f98"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."typed-ast"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "Optional static typing for Python";
      };
    };



    "nixbot" = python.mkDerivation {
      name = "nixbot-0.0";
      src = ./.;
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Flask"
      self."celery"
      self."flower"
      self."github3.py"
      self."mypy"
      self."pycodestyle"
      self."pylint"
      self."pytest-runner"
      self."redis"
      self."setuptools-scm"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "";
        description = "nixbot";
      };
    };



    "pycodestyle" = python.mkDerivation {
      name = "pycodestyle-2.3.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e1/88/0e2cbf412bd849ea6f1af1f97882add46a374f4ba1d2aea39353609150ad/pycodestyle-2.3.1.tar.gz"; sha256 = "682256a5b318149ca0d2a9185d365d8864a768a28db66a84a2ea946bcc426766"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "Python style guide checker";
      };
    };



    "pylint" = python.mkDerivation {
      name = "pylint-1.7.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/cc/8c/d1da590769213fefedea4b345e90fce80f749c61ab9f9187b3fe19397b4b/pylint-1.7.1.tar.gz"; sha256 = "8b4a7ab6cf5062e40e2763c0b4a596020abada1d7304e369578b522e46a6264a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."astroid"
      self."isort"
      self."mccabe"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.gpl1;
        description = "python code static checker";
      };
    };



    "pytest-runner" = python.mkDerivation {
      name = "pytest-runner-2.11.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/9e/4d/08889e5e27a9f5d6096b9ad257f4dea1faabb03c5ded8f665ead448f5d8a/pytest-runner-2.11.1.tar.gz"; sha256 = "983a31eab45e375240e250161a556163bc8d250edaba97960909338c273a89b3"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "Invoke py.test as distutils command with dependency resolution";
      };
    };



    "pytz" = python.mkDerivation {
      name = "pytz-2017.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/a4/09/c47e57fc9c7062b4e83b075d418800d322caa87ec0ac21e6308bd3a2d519/pytz-2017.2.zip"; sha256 = "f5c056e8f62d45ba8215e5cb8f50dfccb198b4b9fbea8500674f3443e4689589"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "World timezone definitions, modern and historical";
      };
    };



    "redis" = python.mkDerivation {
      name = "redis-2.10.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/68/44/5efe9e98ad83ef5b742ce62a15bea609ed5a0d1caf35b79257ddb324031a/redis-2.10.5.tar.gz"; sha256 = "5dfbae6acfc54edf0a7a415b99e0b21c0a3c27a7f787b292eea727b1facc5533"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "Python client for Redis key-value store";
      };
    };



    "requests" = python.mkDerivation {
      name = "requests-2.13.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/16/09/37b69de7c924d318e51ece1c4ceb679bf93be9d05973bb30c35babd596e2/requests-2.13.0.tar.gz"; sha256 = "5722cd09762faa01276230270ff16af7acf7c5c45d623868d9ba116f15791ce8"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "Python HTTP for Humans.";
      };
    };



    "setuptools-scm" = python.mkDerivation {
      name = "setuptools-scm-1.15.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/03/ac/dbb718dd284d41164ceeb3e3d007a1b2b15a688582076833f3fca67ae313/setuptools_scm-1.15.5.tar.gz"; sha256 = "145b2a8a609e0fd66108a92a06fe62d0fb329c0eb944f2d5c7ae3ca24222f29e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "the blessed package to manage your versions by scm tags";
      };
    };



    "six" = python.mkDerivation {
      name = "six-1.10.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz"; sha256 = "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };



    "tornado" = python.mkDerivation {
      name = "tornado-4.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b5/f6/73e51867c998bf8d0f815fcc97f5e6ee6d2ced0b000ef23e8de115546e85/tornado-4.2.tar.gz"; sha256 = "e8b1207da67dbdceebfb291292b4ef1b547d6171525bec1b366853f923456a5f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Tornado is a Python web framework and asynchronous networking library, originally developed at FriendFeed.";
      };
    };



    "typed-ast" = python.mkDerivation {
      name = "typed-ast-1.0.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/89/3d/9684616ba2b69ed73cc51396d777544e8379806fce1d60731b2237c3063c/typed-ast-1.0.3.tar.gz"; sha256 = "67184179697ea9128fa8fec1d3b4e26b41d6a2eceab4674c6e3da4b024309862"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "a fork of Python 2 and 3 ast modules with type comment support";
      };
    };



    "uritemplate" = python.mkDerivation {
      name = "uritemplate-2.0.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ba/83/069aee6d676e890b638c7c7da60063ff6abce00b4bb59d9a9e6249131bfa/uritemplate-2.0.0.tar.gz"; sha256 = "c20c7e024535f9ef0130c5694159ce6210f703f8a7d813a602b020455052b5bf"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "URI templates";
      };
    };



    "vine" = python.mkDerivation {
      name = "vine-1.1.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/35/21/308904b027636f13c3970ed7caf2c53fca77fa160122ae3ac392d9eb6307/vine-1.1.3.tar.gz"; sha256 = "87b95da19249373430a8fafca36f1aecb7aa0f1cc78545877857afc46aea2441"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "Promises, promises, promises.";
      };
    };



    "wrapt" = python.mkDerivation {
      name = "wrapt-1.10.10";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/a3/bb/525e9de0a220060394f4aa34fdf6200853581803d92714ae41fc3556e7d7/wrapt-1.10.10.tar.gz"; sha256 = "42160c91b77f1bc64a955890038e02f2f72986c01d462d53cb6cb039b995cdd9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "Module for decorators, wrappers and monkey patching.";
      };
    };

  };
  overrides = import ./requirements_override.nix { inherit pkgs python; };
  commonOverrides = [

  ];

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            ([overrides] ++ commonOverrides)
         )
   )