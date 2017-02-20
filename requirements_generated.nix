# generated using pypi2nix tool (version: 1.8.0)
#
# COMMAND:
#   pypi2nix -e ./[testing]#egg=nixbot -V 3.6 -v
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
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.bsdOriginal;
      description = "Messaging library for Python.";
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
      self."github3.py"
      self."waitress"
    ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = "";
      description = "nixbot";
    };
  };



  "pytz" = python.mkDerivation {
    name = "pytz-2016.10";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/d0/e1/aca6ef73a7bd322a7fc73fd99631ee3454d4fc67dc2bee463e2adf6bb3d3/pytz-2016.10.tar.bz2"; sha256 = "7016b2c4fa075c564b81c37a252a5fccf60d8964aa31b7f5eae59aeb594ae02b"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.mit;
      description = "World timezone definitions, modern and historical";
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



  "waitress" = python.mkDerivation {
    name = "waitress-1.0.2";
    src = pkgs.fetchurl { url = "https://pypi.python.org/packages/cd/f4/400d00863afa1e03618e31fd7e2092479a71b8c9718b00eb1eeb603746c6/waitress-1.0.2.tar.gz"; sha256 = "c74fa1b92cb183d5a3684210b1bf0a0845fe8eb378fa816f17199111bbf7865f"; };
    doCheck = commonDoCheck;
    buildInputs = commonBuildInputs;
    propagatedBuildInputs = [ ];
    meta = with pkgs.stdenv.lib; {
      homepage = "";
      license = licenses.zpt21;
      description = "Waitress WSGI server";
    };
  };

}