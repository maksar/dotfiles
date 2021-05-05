{ config, pkgs, ... }: {

  services.postgresql = {
    enable = false;
    package = pkgs.postgresql;
    dataDir = config.users.users."${config.mainUser}".home + "/.postgresql";
    enableTCPIP = false;
  };
}
