{ config, lib, pkgs,  ... }:
with lib;
{
  imports = [
    ./bucketer.nix
    ./ldap-bot.nix
    ./gamgee.nix
  ];

  options = {
    mainUser = mkOption {
      type = types.str;
      description = ''
        Name of the main user.
      '';
    };
    homeFolder = mkOption {
      default = "/Users/" + config.mainUser;
      type = types.str;
      description = ''
        Home folder of the main user.
      '';
    };
    projectsFolder = mkOption {
      default = "${config.homeFolder}/projects";
      type = types.str;
      description = ''
        The path to the projects folder in the system.
      '';
    };
  };
}
