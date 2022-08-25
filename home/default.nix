{ config, pkgs, lib, ... }: {

  imports = [
    ./alacritty
    ./vscode
    ./zsh
    ./neovim
    ./git
    ./bat
    ./direnv
    ./os
  ];

  home.packages = with pkgs; [
    home-manager

    ctop
    lazydocker
    dive

    wget
    xdg-utils

    inetutils
    speedtest-cli
    asciinema

    tree
    ncdu
    mc

    awscli2
    aws-mfa

    nix-tree
    nix-index

    comma

    cachix
    autossh # [TODO] Configure a autossh -M 0 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" in ssh config
    mosh

    envsubst

    silver-searcher
    fx
    q-text-as-data
  ];

  programs.man.enable = true;
  programs.autojump.enable = true;
  programs.jq.enable = true;
  programs.dircolors.enable = true;
  programs.fzf.enable = true;
  programs.htop = {
    enable = true;
    settings.show_program_path = true;
  };

  home.sessionVariables = {
    MANPAGER = "${pkgs.most}/bin/most";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
