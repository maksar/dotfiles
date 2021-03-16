{ config, pkgs, ... }: {

  imports = [ ./nix ./pam ./brew ./fonts ./macos ./postgresql ./redis ./mysql ];
}
