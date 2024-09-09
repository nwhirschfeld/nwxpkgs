{ lib
, fetchPypi
, python3Packages
}:

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
in
python3Packages.buildPythonPackage rec {
  pname = "luna-usb";
  version = "0.1.1";
  pyproject = true;

  src = fetchPypi {
    inherit version;
    pname = "luna_usb";
    hash = "sha256-CCOsrtDI1Ax/2MW4cw0HEUaeCg0aMQpQl88TYgfjsdI=";
  };

  build-system = with python3Packages; [
    setuptools
    setuptools-git-versioning
  ];

  dependencies = with python3Packages; [
    pyusb
    pyvcd
    pyserial
    libusb1
    amaranth
    usb-protocol
  ];

  meta = with lib; {
    changelog = "https://github.com/greatscottgadgets/luna/releases";
    description = "Toolkit for working with USB using FPGA technology, providing gateware and software to enable USB applications";
    homepage = "https://github.com/greatscottgadgets/luna";
    license = licenses.bsd3;
    maintainers = with maintainers; [ nw ];
  };
}