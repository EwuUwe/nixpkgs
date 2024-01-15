{ lib
, fetchFromGitHub
, meson
, ninja
, vala
, wrapGAppsHook4
, cmake
, pkg-config
, gettext
, glib
, gtk4
, stdenv
, libadwaita
, blueprint-compiler
, desktop-file-utils
, shared-mime-info
, python3
, appstream-glib
, gobject-introspection
, python3Packages
}:

python3Packages.buildPythonApplication rec {
  pname = "gnome-graphs";
  version = "1.7.1";

  src = fetchFromGitHub {
    owner = "Sjoerd1993";
    repo = "Graphs";
    rev = "v${version}";
    hash = "sha256-wg9YuNDKMQIPwMPV9Pmi0mrQGo34N+vHJR1l7jh20ug=";
  };

  format = "other";

  nativeBuildInputs = [
    appstream-glib
    blueprint-compiler
    desktop-file-utils
    gettext
    glib
    shared-mime-info
    gobject-introspection
    meson
    ninja
    pkg-config
    wrapGAppsHook4
    vala
  ];

  buildInputs = [
    libadwaita
  ];

  propagatedBuildInputs = with python3Packages; [
    pygobject3
    matplotlib
    sympy
    scipy
    numexpr
  ];

  /*
  nativeCheckInputs = with python3.pkgs; [
    pytestCheckHook
  ];
  */

  dontWrapGApps = true;

  postPatch = ''
    substituteInPlace src/meson.build \
      --replace "libgraphs.so" "$out/lib/libgraphs.so"
    '';

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';


  meta = with lib; {
    description = "Plot and manipulate data";
    homepage = "git@github.com:Sjoerd1993/Graphs.git";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ewuuwe ];
    mainProgram = "gnome-graphs";
    platforms = platforms.all;
  };
}
