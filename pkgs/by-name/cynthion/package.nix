{ lib, python3Packages, fetchPypi }:

let
    usb-protocol = python3Packages.buildPythonPackage rec {
      pname = "usb-protocol";
      version = "0.9.1";
      pyproject = true;

      src = fetchPypi {
        inherit version;
        pname = "usb_protocol";
        hash = "sha256-5v9M+WJ5v7XQEH3ZxuTz3gN2LQ9hNvQsSwJH4H3S/iQ=";
      };

      build-system = with python3Packages; [
        setuptools
        setuptools-git-versioning
      ];

      dependencies = with python3Packages; [
        construct
      ];
    };

    amaranth = python3Packages.amaranth.overridePythonAttrs(old: rec {
      version = "0.4.5";
      src =  fetchPypi {
        inherit version;
        pname = "amaranth";
        hash = "sha256-oVD7lFXVqgDg27SWl5cRlQq+guZ2j+FWg7SHxib7WTQ=";
      };
      doCheck = false;
    });

    pyfwup = python3Packages.pyfwup.overridePythonAttrs(old: rec {
      version = "0.5.2";
      src =  fetchPypi {
        inherit version;
        pname = "pyfwup";
        hash = "sha256-oY5dRcgUJ+7fD4OrN1C12CQZFg6BmrBbyK4Sq6PPP50=";
      };
    });

    pygreat = python3Packages.buildPythonPackage rec {
      pname = "pygreat";
      version = "2024.0.2";
      pyproject = true;

      src = fetchPypi {
        inherit pname version;
        hash = "sha256-VGZyvGLPyA6tOVh7boz4j/6o/iQ9mRvULOleFypGHGY=";
      };

      preBuild = ''
        substituteInPlace pyproject.toml --replace " \"backports.functools_lru_cache\"," ""
        substituteInPlace pygreat/comms.py --replace "from backports.functools_lru_cache import lru_cache as memoize_with_lru_cache" "from functools import lru_cache as memoize_with_lru_cache"
        echo "$version" > ../VERSION
      '';

      build-system = with python3Packages; [
        setuptools
        setuptools-git-versioning
      ];

      dependencies = with python3Packages; [
        pyusb
        future
      ];
    };
in
python3Packages.buildPythonApplication rec {
  pname = "cynthion";
  version = "0.1.5";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-D1E6SH75CRi3Dcqa3DxgggdKz7CchqU+m61DrJvVrVg=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml --replace "amaranth==0.4.1" "amaranth==0.4.5"
  '';

  build-system = with python3Packages; [
    setuptools
    setuptools-git-versioning
  ];

  dependencies = with python3Packages; [
    pyusb
    future
    libusb1
    prompt-toolkit
    pyfwup
    pygreat
    pyserial
    tabulate
    amaranth
    tomli
    pkgs.apollo-fpga
    pkgs.luna-usb
    pkgs.luna-soc
  ];

  meta = with lib; {
    changelog = "https://github.com/greatscottgadgets/cynthion/releases";
    description = "a USB Test Instrument";
    homepage = "https://github.com/greatscottgadgets/cynthion";
    license = licenses.bsd3;
    maintainers = with maintainers; [ nw ];
  };
}