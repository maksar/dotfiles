{ config, pkgs, ... }: {

  imports = [
    ./pam.nix
  ];

  security.pam.enableSudoTouchIdAuth = true;
}