{ config, pkgs, system, ... }: {

  imports = [
    ./kitty
    ./vscode
    ./zsh
    ./neovim
    ./git
    ./bat
    ./direnv
    ];

  home.file."Library/KeyBindings/DefaultKeyBinding.dict".text =
    ''
      {
        "\UF729"  = moveToBeginningOfParagraph:; // home
        "\UF72B"  = moveToEndOfParagraph:; // end
        "$\UF729" = moveToBeginningOfParagraphAndModifySelection:; // shift-home
        "$\UF72B" = moveToEndOfParagraphAndModifySelection:; // shift-end
        "^\UF729" = moveToBeginningOfDocument:; // ctrl-home
        "^\UF72B" = moveToEndOfDocument:; // ctrl-end
        "^$\UF729" = moveToBeginningOfDocumentAndModifySelection:; // ctrl-shift-home
        "^$\UF72B" = moveToEndOfDocumentAndModifySelection:; // ctrl-shift-end
      }
    '';

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
  programs.dircolors.enable = true;
  programs.fzf.enable = true;
  programs.htop = {
    enable = true;
    settings.show_program_path = true;
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
