{
  pkgs,
  lib,
}:
pkgs.stdenv.mkDerivation {
  pname = "zh-fonts-pack";
  version = "1.0";
  src = ./zh-fonts;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp -r $src/*.{ttf,otf,ttc} $out/share/fonts/truetype
  '';

  meta = with lib; {
    description = "中文字体包";
    homepace = "https://gitcode.com/open-source-toolkit/bd75c";
    platforms = platforms.all;
  };
}
