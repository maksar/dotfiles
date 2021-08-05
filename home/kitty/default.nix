{ config, pkgs, ... }:

{
  home.packages = [ pkgs.coreutils ];

  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./kitty.conf;
  };
}
