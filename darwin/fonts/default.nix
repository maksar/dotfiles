{ config, pkgs, ... }: {
  fonts = {
    enableFontDir = true;
    fonts = [
      (pkgs.stdenv.mkDerivation rec {
        pname = "pragmata-pro";
        version = "0.8.28";

        src = pkgs.fetchzip {
          url =
            "https://www.dropbox.com/s/dl/mexic1tzi7sxtpt/${pname}-${version}.zip";
          sha256 = "sha256-J51UWZrhPDsNnqN26i3RRJnM9GA9+Ynqp1eh1DR5cfA=";
        };

        installPhase = ''
          mkdir -p $out/share/fonts
          ls
          install -m644 Pragmata/*.ttf $out/share/fonts/
        '';
      })
    ];
  };
}
