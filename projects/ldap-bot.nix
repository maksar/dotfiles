{ config, lib, pkgs, ... }:
let
  ldapBotFolder = "${config.projectsFolder}/ldap-bot";
  ldapBot = (builtins.getFlake ldapBotFolder).packages.${pkgs.system}.console;
in
{
  environment.systemPackages = [ ldapBot ];

  environment.extraInit = ''
    set -o allexport
    source ${ldapBotFolder}/.env.development
    set +o allexport
  '';
}
