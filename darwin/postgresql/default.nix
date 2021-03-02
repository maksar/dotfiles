{ config, pkgs, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
    dataDir = config.users.users.${config.mainUser}.home + "/.postgresql";
    enableTCPIP = true;

    extraConfig = "listen_addresses = 'localhost'";
  };

}
