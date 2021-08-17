{ config, pkgs, ... }: {
  imports = [
    ./kitty
    ./vscode
    ./zsh
    ./neovim
    ./git
    ./bat
    ./direnv
    ];

  home.packages = with pkgs; [
    home-manager

    ctop

    telnet
    asciinema
    tree
    ag

    ranger

    nix-tree
    nix-index

    pandoc

    comma

    cachix
  ];

  programs.man.enable = true;
  programs.autojump.enable = true;
  programs.jq.enable = true;
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;
  programs.dircolors.enable = true;
  programs.fzf.enable = true;

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
