{ config, pkgs, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
    dataDir = "${
        (builtins.getAttr
          (builtins.head (builtins.attrNames config.users.users))
          config.users.users).home
      }/.postgresql";
    enableTCPIP = true;

    extraConfig = "listen_addresses = 'localhost'";
  };

}
