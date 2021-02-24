{ config, lib, pkgs, ... }:
let
  gamgee = (builtins.getFlake (builtins.toString ./gamgee)).defaultPackage.${pkgs.system};
in
{
  environment.systemPackages = [ gamgee ];
}
