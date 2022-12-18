{ config, pkgs, ... }: {
  fonts = {
    fontDir.enable = true;
    fonts = [
      (pkgs.stdenv.mkDerivation rec {
        pname = "pragmata-pro";
        version = "0.8.28";

        src = pkgs.fetchzip {
          url = "${config.home-manager.users.${config.users.primaryUser}.dropboxLocation}/${pname}-${version}.zip";
          stripRoot = false;
          sha256 = "sha256-J51UWZrhPDsNnqN26i3RRJnM9GA9+Ynqp1eh1DR5cfA=";
        };

        installPhase = ''
          mkdir -p $out/share/fonts
          install -m644 Pragmata/*.ttf $out/share/fonts/
        '';
      })
    ];
  };
}
