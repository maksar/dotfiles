{ config, pkgs, ... }:
let userConfig = config.home-manager.users.${config.users.primaryUser};
in
{
  fonts = {
    packages = pkgs.lib.optionals userConfig.dropboxEnabled [
      (pkgs.stdenv.mkDerivation rec {
        pname = "pragmata-pro";
        version = "0.8.28";

        src = pkgs.fetchzip {
          url = "${userConfig.dropboxLocation}/${pname}-${version}.zip";
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
