# generated using pypi2nix tool (version: 1.8.0)
#
# COMMAND:
#   pypi2nix -e ./[testing]#egg=nixbot -V 3.5 -v
#

{ pkgs, python, commonBuildInputs ? [], commonDoCheck ? false }:

self: {

  "Flask" = python.mkDerivation {
    name = "Flask-0.12";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4b/3a/4c20183df155dd2e39168e35d53a388efb384a512ca6c73001d8292c094a/Flask-0.12.tar.gz"; sha256 = "93e803cdbe326a61ebd5c5d353959397c85f829bec610d59cb635c9f97d7ca8b"; };
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
    name = "Jinja2-2.9.5";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/71/59/d7423bd5e7ddaf3a1ce299ab4490e9044e8dfd195420fc83a24de9e60726/Jinja2-2.9.5.tar.gz"; sha256 = "702a24d992f856fa8d5a7a36db6128198d0c21e1da34448ca236c42e92384825"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."MarkupSafe"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "A small but fast and easy to use stand-alone template engine written in pure python.";
    };
  };



  "MarkupSafe" = python.mkDerivation {
    name = "MarkupSafe-0.23";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c0/41/bae1254e0396c0cc8cf1751cb7d9afc90a602353695af5952530482c963f/MarkupSafe-0.23.tar.gz"; sha256 = "a4ec1aff59b95a14b45eb2e23761a0179e98319da5a7eb76b56ea8cdc7b871c3"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "Implements a XML/HTML/XHTML Markup safe string for Python";
    };
  };



  "WebOb" = python.mkDerivation {
    name = "WebOb-1.7.1";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c3/6f/fc168ab701ab8f3741ed0b1377edda676c3e7db61858cef1f72969413968/WebOb-1.7.1.tar.gz"; sha256 = "3b2e3e4a46ce92614fb7d85081a63d03fa0c714dbe0195d5d91ec0205526c83f"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."coverage"
      self."pytest"
      self."pytest-cov"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "WSGI request and response object";
    };
  };



  "WebTest" = python.mkDerivation {
    name = "WebTest-2.0.25";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/d6/f4/604690ec18c0406be1a12f823be215c83be1ebe4cb4621195d366a3dde98/WebTest-2.0.25.tar.gz"; sha256 = "c81bdc2e869e42d2120ca4ef50db353cffb52065fcec852e94b2729b312ba548"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."WebOb"
      self."beautifulsoup4"
      self."coverage"
      self."six"
      self."waitress"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "Helper to test WSGI applications";
    };
  };



  "Werkzeug" = python.mkDerivation {
    name = "Werkzeug-0.11.15";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/fe/7f/6d70f765ce5484e07576313897793cb49333dd34e462488ee818d17244af/Werkzeug-0.11.15.tar.gz"; sha256 = "455d7798ac263266dbd38d4841f7534dd35ca9c3da4a8df303f8488f38f3bcc0"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "The Swiss Army knife of Python web development";
    };
  };



  "appdirs" = python.mkDerivation {
    name = "appdirs-1.4.0";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/bd/66/0a7f48a0f3fb1d3a4072bceb5bbd78b1a6de4d801fb7135578e7c7b1f563/appdirs-1.4.0.tar.gz"; sha256 = "8fc245efb4387a4e3e0ac8ebcc704582df7d72ff6a42a53f5600bbb18fdaadc5"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "A small Python module for determining appropriate \" +         \"platform-specific dirs, e.g. a \"user data dir\".";
    };
  };



  "beautifulsoup4" = python.mkDerivation {
    name = "beautifulsoup4-4.5.3";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/9b/a5/c6fa2d08e6c671103f9508816588e0fb9cec40444e8e72993f3d4c325936/beautifulsoup4-4.5.3.tar.gz"; sha256 = "b21ca09366fa596043578fd4188b052b46634d22059e68dd0077d9ee77e08a3e"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "Screen-scraping library";
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



  "coverage" = python.mkDerivation {
    name = "coverage-4.3.4";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/6e/33/01cb50da2d0582c077299651038371dba988248058e03c7a7c4be0c84c40/coverage-4.3.4.tar.gz"; sha256 = "eaaefe0f6aa33de5a65f48dd0040d7fe08cac9ac6c35a56d0a7db109c3e733df"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.asl20;
      description = "Code coverage measurement for Python";
    };
  };



  "github3.py" = python.mkDerivation {
    name = "github3.py-0.9.6";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c7/44/69354d18979a0f30b09ec391294798e96aa578665f3d1fea4377759e3b56/github3.py-0.9.6.tar.gz"; sha256 = "b831db85d7ff4a99d6f4e8368918095afeea10f0ec50798f9a937c830ab41dc5"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."pytest"
      self."requests"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = "Redistribution and use in source and binary forms, with or without ";
      description = "Python wrapper for the GitHub API(http://developer.github.com/v3)";
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



  "nixbot" = python.mkDerivation {
    name = "nixbot-0.0";
    src = ./.;
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."Flask"
      self."WebTest"
      self."github3.py"
      self."pytest"
      self."pytest-cov"
      self."waitress"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = "";
      description = "nixbot";
    };
  };



  "packaging" = python.mkDerivation {
    name = "packaging-16.8";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c6/70/bb32913de251017e266c5114d0a645f262fb10ebc9bf6de894966d124e35/packaging-16.8.tar.gz"; sha256 = "5d50835fdf0a7edf0b55e311b7c887786504efea1177abd7e69329a8e5ea619e"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."pyparsing"
      self."six"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "Core utilities for Python packages";
    };
  };



  "py" = python.mkDerivation {
    name = "py-1.4.32";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/93/bd/8a90834a287e0c1682eab8e20ada672e4f4cf7d5b99f2833ddbf31ed1a6d/py-1.4.32.tar.gz"; sha256 = "c4b89fd1ff1162375115608d01f77c38cca1d0f28f37fd718005e19b28be41a7"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "library with cross-python path, ini-parsing, io, code, log facilities";
    };
  };



  "pyparsing" = python.mkDerivation {
    name = "pyparsing-2.1.10";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/38/bb/bf325351dd8ab6eb3c3b7c07c3978f38b2103e2ab48d59726916907cd6fb/pyparsing-2.1.10.tar.gz"; sha256 = "811c3e7b0031021137fc83e051795025fcb98674d07eb8fe922ba4de53d39188"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "Python parsing module";
    };
  };



  "pytest" = python.mkDerivation {
    name = "pytest-3.0.6";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/68/9c/c06dc051b39b817efd31e4c589df7780f7b287d96fab67e90be1f614fc0a/pytest-3.0.6.tar.gz"; sha256 = "643434a9f1a188271da35e20064cb8b6c5440976c5bb541dc7b5b0e3cf75d940"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."py"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "pytest: simple powerful testing with Python";
    };
  };



  "pytest-cov" = python.mkDerivation {
    name = "pytest-cov-2.4.0";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/00/c0/2bfd1fcdb9d407b8ac8185b1cb5ff458105c6b207a9a7f0e13032de9828f/pytest-cov-2.4.0.tar.gz"; sha256 = "53d4179086e1eec1c688705977387432c01031b0a7bd91b8ff6c912c08c3820d"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."coverage"
      self."pytest"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "Pytest plugin for measuring coverage.";
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



  "waitress" = python.mkDerivation {
    name = "waitress-1.0.2";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/cd/f4/400d00863afa1e03618e31fd7e2092479a71b8c9718b00eb1eeb603746c6/waitress-1.0.2.tar.gz"; sha256 = "c74fa1b92cb183d5a3684210b1bf0a0845fe8eb378fa816f17199111bbf7865f"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [
      self."coverage"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.zpt21;
      description = "Waitress WSGI server";
    };
  };

}