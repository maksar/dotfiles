a@{ config, pkgs, darwinConfig, ... }:
let
  rigel = (pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "rigel";
    version = "2020-08-25";
    src = pkgs.fetchFromGitHub {
      owner = "Rigellute";
      repo = "rigel";
      rev = "83874d9abd7c5f5df881df75d6c5e41ea26e39de";
      sha256 = "1rprzhp1vbis5jz464pb4vmaj2r8r62fki7s5ddxh1v0j4i1sb97";
    };
    dependencies = [ ];
  });

  issw = (pkgs.stdenv.mkDerivation rec {
    pname = "issw";
    version = "v0.3";

    src = pkgs.fetchFromGitHub {
      owner = "vovkasm";
      repo = "input-source-switcher";
      rev = version;
      sha256 = "sha256-JjMNdpqt10CHpUGt5kX15bVDmqm1CbD5lqyLlXY1Jfg=";
    };

    nativeBuildInputs = [ pkgs.cmake ];
    buildInputs = [ pkgs.darwin.apple_sdk.frameworks.Carbon ];
  });

  vim-xkbswitch-mac = pkgs.vimPlugins.vim-xkbswitch.overrideAttrs (old: {
    patchPhase = ''
      substituteInPlace plugin/xkbswitch.vim --replace /usr/local/lib/libxkbswitch.dylib ${issw}/lib/libInputSourceSwitcher.dylib
    '';
    buildInputs = [ issw ];
  });
in {

  home.packages = [ pkgs.nix-prefetch-git ];
  sn.programs.neovim = {
    extraConfig = builtins.readFile ./vimrc;

    pluginRegistry = {
      vim-devicons = {
        enable = true;
        after = [
          "nerdtree"
          "vim-airline"
          "ctrlp-vim"
          "powerline/powerline"
          "denite-nvim"
          "unite-vim"
          "lightline-vim"
          "vim-startify"
          "vimfiler"
          "vim-flagship"
        ];
      };

      vim-airline-themes = { enable = true; };
      vim-airline = {
        enable = true;
        extraConfig = ''
          let g:airline_powerline_fonts = 1
          let g:airline#extensions#tabline#enabled = 1

        '';
      };

      rigel = {
        enable = true;
        source = rigel;
        extraConfig = ''
          set notermguicolors
          syntax enable

          colorscheme rigel
        '';
      };

      vim-xkbswitch-mac = {
        enable = true;
        source = if config.isLinux then pkgs.vimPlugins.vim-xkbswitch else vim-xkbswitch-mac;
        extraConfig = "let g:XkbSwitchEnabled = 1";
      };

      ctrlp-vim.enable = true;
      vim-nix.enable = true;
      vim-gitgutter.enable = true;
      vim-startify.enable = true;
      coc-nvim = {
        enable = true;
        binDeps = [ pkgs.nodejs ];
      };
      fzf-vim.enable = true;
      nerdtree.enable = true;
      haskell-vim.enable = true;
      vim-markdown.enable = true;
    };
  };
}
