{ config, pkgs, lib, ... }:
let osSpecific = import (./. + "/${config.os}.nix");
in
{
  options = {
    os = lib.mkOption { type = lib.types.str; };
    isDarwin = lib.mkOption { type = lib.types.bool; };
    isLinux = lib.mkOption { type = lib.types.bool; };
    dropboxLocation = lib.mkOption { type = lib.types.str; };
    dropboxEnabled = lib.mkOption { type = lib.types.bool; };
  };

  config = {
    isDarwin = config.os == "darwin";
    isLinux = config.os == "linux";
    inherit (osSpecific) home;
    dropboxLocation = "${config.home.homeDirectory}/${osSpecific.dropboxRelativeLocation}";
  };
}
