{ config, pkgs, ... }: {

  imports = [ ./mysql.nix ];

  services.mysql = {
    enable = true;
    dataDir = config.users.users.${config.mainUser}.home + "/.mysql";
    bind = "127.0.0.1";
  };
}
