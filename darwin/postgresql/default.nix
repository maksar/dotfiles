{ config, pkgs, ... }: {

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
    dataDir = config.users.users."${config.users.primaryUser}".home + "/.postgresql";
    enableTCPIP = false;
  };
}
