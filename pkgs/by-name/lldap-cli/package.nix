{ stdenv
, lib
, fetchFromGitHub
, lldap
, bash
, coreutils
, gnugrep
, gnused
, jq
, curl
, makeWrapper
}:
stdenv.mkDerivation {
  pname = "lldap-cli";
  version = "0-unstable-2024-02-24";

  src = fetchFromGitHub {
    owner = "nwhirschfeld";
    repo = "lldap-cli";
    rev = "e90a0ed1a2331cf7d3e625513948f7e67078f4d7";
    hash = "sha256-+diQQm6K41Tc4SuF3R3GudPSL20HkEMA/IbNORX13n4=";
  };

  nativeBuildInputs = [ makeWrapper ];

  patchPhase = ''
    runHook prePatch

    # fix .lldap-cli-wrapped showing up in usage
    substituteInPlace lldap-cli \
      --replace-fail '$(basename $0)' lldap-cli

    runHook postPatch
  '';

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    install -Dm555 lldap-cli -t $out/bin
    wrapProgram $out/bin/lldap-cli \
      --prefix PATH : ${lib.makeBinPath [ lldap bash coreutils gnugrep gnused jq curl ]}
  '';

  meta = {
    description = "Command line tool for managing LLDAP";
    longDescription = ''
      LDAP-CLI is a command line interface for LLDAP.

      LLDAP uses GraphQL to offer an HTTP-based API.
      This API is used by an included web-based user interface.
      Unfortunately, LLDAP lacks a command-line interface,
      which is a necessity for any serious administrator.
      LLDAP-CLI translates CLI commands to GraphQL API calls.
    '';
    homepage = "https://github.com/Zepmann/lldap-cli";
    license = lib.licenses.gpl3Only;
    maintainers = [ lib.maintainers.nw ];
    mainProgram = "lldap-cli";
    platforms = lib.platforms.unix;
  };
}
