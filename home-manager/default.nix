{ config, pkgs, ... }: {
  imports = [ ./kitty ./vscode ./zsh ./neovim ./git ./bat ];

  home.packages = with pkgs; [
    home-manager

    ctop

    telnet
    asciinema
    tree
    ag

    ranger

    nix-tree

    pandoc
  ];

  programs.man.enable = true;
  programs.autojump.enable = true;
  programs.jq.enable = true;
  programs.htop.enable = true;
  programs.dircolors.enable = true;
  programs.fzf.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
      enableFlakes = true;
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
