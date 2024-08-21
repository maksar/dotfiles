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

  manual.html.enable = false;
  manual.json.enable = false;
  manual.manpages.enable = false;

  home.packages = with pkgs; [
    nixVersions.latest

    home-manager

    ctop
    lazydocker
    dive

    wget
    xdg-utils

    inetutils
    speedtest-cli
    asciinema

    fd
    entr
    tree
    broot
    # ncdu
    dua
    duf
    mc

    awscli2
    ssm-session-manager-plugin
    aws-mfa

    nix-tree
    nix-index
    nix-top

    comma

    cachix
    iperf
    mtr
    nmap

    envsubst

    silver-searcher
    fx
    q-text-as-data

  ];

  programs.man.enable = true;
  # programs.autojump.enable = true;
  programs.jq.enable = true;
  programs.dircolors.enable = true;
  programs.fzf = {
    enable = true;
    fileWidgetOptions = ["--preview 'bat --color=always --style=header,grid --line-range :500 {}'"];
  };
  programs.htop = {
    enable = true;
    settings.show_program_path = true;
  };

  home.sessionVariables = {
    MANPAGER = "${pkgs.most}/bin/most";
  } // (if config.isLinux then {} else { SSH_AUTH_SOCK = "${config.home.homeDirectory}/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"; });

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
