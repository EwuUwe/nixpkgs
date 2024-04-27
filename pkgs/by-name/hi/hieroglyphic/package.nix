{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
, cargo
, desktop-file-utils
, git
, itstool
, meson
, ninja
, pkg-config
, python3
, rustc
, wrapGAppsHook4
, gtk4
, libadwaita
, libsecret
}:

stdenv.mkDerivation rec {
  pname = "hieroglyphic";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "FineFindus";
    repo = "hieroglyphic";
    rev = "v${version}";
    hash = "sha256-Twx3yM71xn2FT3CbiFGbo2knGvb4MBl6VwjWlbjfks0=";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-Se/YCi0e+Uoh5guDteLRXZYyk7et0NA8cv+vNpLxzx4=";
  };

  postPatch = ''
    patchShebangs build-aux
  '';

  nativeBuildInputs = [
    desktop-file-utils
    git
    itstool
    meson
    ninja
    pkg-config
    python3
    wrapGAppsHook4
    rustPlatform.cargoSetupHook
    cargo
    rustc
  ];

  buildInputs = [
    gtk4
    libadwaita
    libsecret
  ];

  meta = with lib; {
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ ewuuwe ];
    platforms = platforms.linux;
  };
}
