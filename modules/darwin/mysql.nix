{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.mysql;

  mysql = cfg.package;

  mysqldOptions =
    "--defaults-file=/etc/my.cnf --user=${config.users.primaryUser} --datadir=${cfg.dataDir} --basedir=${mysql}";

in {
  options = {
    services.mysql = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to run mysql.";
      };

      package = mkOption {
        type = types.package;
        default = pkgs.mariadb;
        defaultText = "pkgs.mariadb";
        description = "mysql package to use.";
      };

      port = mkOption {
        type = types.int;
        default = 3306;
        description = "Port of MySQL.";
      };

      dataDir = mkOption {
        type = types.path;
        default = "/var/lib/mysql";
        example = "/var/lib/mysql/9.6";
        description = "Data directory for mysql.";
      };

      bind = mkOption {
        type = types.nullOr types.str;
        default = null;
        example = literalExample "0.0.0.0";
        description =
          "Address to bind to. The default is to bind to all addresses.";
      };

      extraConfig = mkOption {
        type = types.lines;
        default = "";
        description =
          "Additional text to be appended to <filename>mysql.conf</filename>.";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ mysql ];

    environment.etc."my.cnf".text = ''
      [mysqld]
      port = ${toString cfg.port}
      socket = ${cfg.dataDir}/socket
      datadir = ${cfg.dataDir}
      ${optionalString (cfg.bind != null) "bind-address = ${cfg.bind}"}
      ${cfg.extraConfig}
    '';

    launchd.user.agents.mysql = {
      path = [ mysql ];
      script = ''
        source ${config.users.users.${config.users.primaryUser}.home}/.nix-profile/etc/profile.d/nix.sh
        zsh -l -c "
          mysql_install_db ${mysqldOptions} --auth-root-authentication-method=normal
          exec mysqld ${mysqldOptions}
        "
      '';

      serviceConfig.KeepAlive = true;
      serviceConfig.RunAtLoad = true;
    };

  };
}
