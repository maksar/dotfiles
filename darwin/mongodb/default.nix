{ config, pkgs, ... }: {

  imports = [ ./mongodb.nix ];

  services.mongodb = {
    enable = true;
    dataDir = config.users.users.${config.mainUser}.home + "/.mongodb";
    bind = "127.0.0.1";
  };
}
