{ lib, python3Packages, fetchPypi }:

python3Packages.buildPythonPackage rec {
  pname = "apollo-fpga";
  version = "1.1.0";
  pyproject = true;

  src = fetchPypi {
    inherit version;
    pname = "apollo_fpga";
    hash = "sha256-dLccmQ/2ZhQqL17JkpAhtuO5jZ3oUuIVcuYdQR0zwhQ=";
  };

  nativeBuildInputs = with python3Packages; [
    setuptools
    setuptools-git-versioning
    prompt-toolkit
    pyxdg
    deprecation
    pyusb
    pyvcd
  ];
  

  meta = with lib; {
    changelog = "https://git.goral.net.pl/i3a.git/log/";
    description = "Set of scripts used for automation of i3 and sway window manager layouts";
    homepage = "https://git.goral.net.pl/i3a.git/about";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ nw ];
  };
}