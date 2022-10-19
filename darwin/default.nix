{ config, pkgs, ... }: {

  imports = [
    ./nix
    ./pam
    ./brew
    ./fonts
    ./macos
  ];

  documentation.enable = false;
}
