{
  lib,
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
  libtool,
  m4,
  pkg-config,
  libjpeg,
  libpng,
  ffmpeg,
  glib,
  gdk-pixbuf,
  SDL2,
  libxml2,
  libjack2,
  freetype,
  directfb,
  libdv,
  qrencode,
  veejay-core,
  jackSupport ? true,
}:
stdenv.mkDerivation {
  name = "veejay-server";
  version = "2024-06-16-git";
  src = fetchFromGitHub {
    owner = "game-stop";
    repo = "veejay";
    rev = "4e21d31dde3a888c7115ba4ac38e7c48366687f7";
    sha256 = "sha256-CY4mSz9A0uyJJTKevplK7MkSopbT/g1Gqg6u3Keasgo=";
  };
  sourceRoot = "source/veejay-current/veejay-server";
  preConfigure = "./autogen.sh";
  nativeBuildInputs = [
    autoconf
    automake
    libtool
    m4
    pkg-config
  ];
  buildInputs =
    [
      libjpeg
      libpng
      ffmpeg
      glib
      gdk-pixbuf
      SDL2
      libxml2
      freetype
      directfb
      libdv
      qrencode
      veejay-core
    ]
    ++ lib.optional jackSupport libjack2;
}
