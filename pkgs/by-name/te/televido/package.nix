{ lib
, stdenv
, fetchFromGitHub
, cargo
, meson
, ninja
, desktop-file-utils
, pkg-config
, rustPlatform
, rustc
, wrapGAppsHook4
, cairo
, gdk-pixbuf
, glib
, gtk4
, libadwaita
, openssl
, pango
, blueprint-compiler
, appstream
, appstream-glib
, gettext
, glibc
, gio-sharp
}:

stdenv.mkDerivation rec {
  pname = "televido";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "d-k-bo";
    repo = "televido";
    rev = "v${version}";
    hash = "sha256-qfUwPyutBNEnplD3kmTJXffzcWkEcR6FTLnT5YDSysU=";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-CmQQH6a5xMq+v+P4/sbpQ7iDaGKtzV39FgufD5uxz4Y=";
  };

  PKG_CONFIG_PATH = "${glib.dev}/lib/pkgconfig";
  nativeBuildInputs = [
    desktop-file-utils
    cargo
    meson
    gettext
    gio-sharp
    ninja
    glibc
    pkg-config
    rustPlatform.cargoSetupHook
    rustc
    wrapGAppsHook4
    blueprint-compiler
    appstream
    appstream-glib
    glib #a
  ];

  buildInputs = [
    cairo
    gdk-pixbuf
    glib
    gtk4
    libadwaita
    openssl
    pango
  ];

  meta = with lib; {
    description = "Access German-language public broadcasting live streams and archives on the Linux Desktop";
    homepage = "https://github.com/d-k-bo/televido";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ];
    mainProgram = "televido";
    platforms = platforms.all;
  };
}
