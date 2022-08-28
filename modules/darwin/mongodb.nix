{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.mongodb;

  mongodb = cfg.package;

  mongodbdOptions =
    "--defaults-file=/etc/my.cnf --user=${config.mainUser} --datadir=${cfg.dataDir} --basedir=${mongodb}";

in {
  options = {
    services.mongodb = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to run mongodb.";
      };

      package = mkOption {
        type = types.package;
        default = pkgs.mongodb;
        defaultText = "pkgs.mongodb";
        description = "mongodb package to use.";
      };

      dataDir = mkOption {
        type = types.path;
        default = "/var/lib/mongodb";
        example = "/var/lib/mongodb/3.4";
        description = "Data directory for mongodb.";
      };

      bind = mkOption {
        type = types.nullOr types.str;
        default = null;
        example = literalExpression "0.0.0.0";
        description =
          "Address to bind to. The default is to bind to all addresses.";
      };

      extraConfig = mkOption {
        type = types.lines;
        default = "";
        description =
          "Additional text to be appended to <filename>mongodb.conf</filename>.";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ mongodb ];

    environment.etc."mongodb.conf".text = ''
      net.bindIp: ${cfg.bind}
      storage.dbPath: ${cfg.dataDir}
      ${cfg.extraConfig}
    '';

    launchd.user.agents.mongodb = {
      path = [ mongodb ];
      script = ''
        ${mongodb}/bin/mongod --config /etc/mongodb.conf --pidfilepath ${cfg.dataDir}/pidfile
      '';

      serviceConfig.KeepAlive = true;
      serviceConfig.RunAtLoad = true;
    };

  };
}
