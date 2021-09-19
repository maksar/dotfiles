{ config, pkgs, lib, ... }: {

  options = {
    os = lib.mkOption { type = lib.types.str; };
    isDarwin = lib.mkOption { type = lib.types.bool; };
    isLinux = lib.mkOption { type = lib.types.bool; };
  };

  config = {
    isDarwin = config.os == "darwin";
    isLinux = config.os == "linux";
    inherit (import (./. + "/${config.os}.nix")) home;
  };
}
