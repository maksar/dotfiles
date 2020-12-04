{ config, lib, pkgs, ... }:
let
  bucketerFolder = "${config.projectsFolder}/bucketer";
  bucketer = import bucketerFolder { };
in
{
  environment.systemPackages = [ bucketer ];

  environment.extraInit = ''
    set -o allexport
    source ${bucketerFolder}/.env
    set +o allexport
  '';


  launchd.user.agents.bucketer = {
    script = ''
      source ${config.homeFolder}/.nix-profile/etc/profile.d/nix.sh
      ${config.environment.extraInit}
      ${bucketer}/bin/repositories
      ${bucketer}/bin/open_pulls
    '';
    serviceConfig.KeepAlive = false;
    serviceConfig.StartInterval = 1800;
  };
}
