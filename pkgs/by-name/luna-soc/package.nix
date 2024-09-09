{ lib
, fetchPypi
, python3Packages
, pkgs
}:

python3Packages.buildPythonPackage rec {
  pname = "luna-soc";
  version = "0.2.0";
  pyproject = true;

  src = fetchPypi {
    inherit version;
    pname = "luna_soc";
    hash = "sha256-Ohz/dkUuV/yoEphB7/YohuCp5GMQ//0NF1BPySg3IeU=";
  };

  build-system = with python3Packages; [
    setuptools
    setuptools-git-versioning
  ];

  dependencies = with pkgs; [
    luna-usb
  ];

  meta = with lib; {
    changelog = "https://github.com/greatscottgadgets/luna-soc/releases/tag/0.2.0";
    description = "Amaranth HDL libary for building USB-capable SoC designs";
    homepage = "https://github.com/greatscottgadgets/luna-soc";
    license = licenses.bsd3;
    maintainers = with maintainers; [ nw ];
  };
}