{ config, pkgs, ... }: {

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_12;
    dataDir = config.users.users."${config.users.primaryUser}".home + "/.postgresql";
    enableTCPIP = false;
  };
}
