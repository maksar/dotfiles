{ config, pkgs, ... }: {

  services.mongodb = {
    enable = true;
    dataDir = config.users.users.${config.users.primaryUser}.home + "/.mongodb";
    bind = "127.0.0.1";
  };
}
