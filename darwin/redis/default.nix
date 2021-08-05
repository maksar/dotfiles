{ config, pkgs, ... }: {

  services.redis = {
    enable = true;
    bind = "localhost";
    dataDir = config.users.users.${config.users.primaryUser}.home + "/.redis";
  };

}
