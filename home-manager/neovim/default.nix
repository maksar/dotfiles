{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-airline
      vim-airline-themes
      ctrlp-vim
      vim-nix
      vim-gitgutter
      vim-startify
      coc-nvim
      fzf-vim

      (pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "rigel";
        version = "2020-08-25";
        src = pkgs.fetchFromGitHub {
          owner = "Rigellute";
          repo = "rigel";
          rev = "83874d9abd7c5f5df881df75d6c5e41ea26e39de";
          sha256 = "1rprzhp1vbis5jz464pb4vmaj2r8r62fki7s5ddxh1v0j4i1sb97";
        };
        dependencies = [ ];
      })

    ];

    extraConfig = builtins.readFile ./vimrc;
  };

}
