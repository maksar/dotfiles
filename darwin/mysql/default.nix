{ config, pkgs, ... }: {

  services.mysql = {
    enable = true;
    dataDir = config.users.users.${config.users.primaryUser}.home + "/.mysql";
    bind = "127.0.0.1";
  };
}
