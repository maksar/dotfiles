a@{ config, pkgs, darwinConfig, ... }:
{

  home.packages = [ pkgs.nix-prefetch-git ];
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    coc = {
      enable = true;
      settings = {
        "suggest.noselect" = true;
        "suggest.enablePreview" = true;
        "suggest.enablePreselect" = false;
        "suggest.disableKind" = true;
        languageserver = {
          haskell = {
            command = "haskell-language-server-wrapper";
            args = [ "--lsp" ];
            rootPatterns = [
              "*.cabal"
              "stack.yaml"
              "cabal.project"
              "package.yaml"
              "hie.yaml"
            ];
            filetypes = [ "haskell" "lhaskell" ];
          };
        };
      };
    };
    plugins = with pkgs.vimPlugins;
      let
        issw = pkgs.stdenv.mkDerivation rec {
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
        };

        vim-xkbswitch-mac = vim-xkbswitch.overrideAttrs (_: {
          patchPhase = ''
            substituteInPlace plugin/xkbswitch.vim --replace /usr/local/lib/libxkbswitch.dylib ${issw}/lib/libInputSourceSwitcher.dylib
          '';
          buildInputs = [ issw ];
        });

        rigel = pkgs.vimUtils.buildVimPlugin {
          pname = "rigel";
          version = "2020-08-25";
          src = pkgs.fetchFromGitHub {
            owner = "Rigellute";
            repo = "rigel";
            rev = "83874d9abd7c5f5df881df75d6c5e41ea26e39de";
            sha256 = "1rprzhp1vbis5jz464pb4vmaj2r8r62fki7s5ddxh1v0j4i1sb97";
          };
        };
      in [
        {
          plugin = rigel;
          config = ''
            set notermguicolors
            syntax enable
            colorscheme rigel
          '';
        }
        vim-airline-themes
        {
          plugin = vim-airline;
          config = ''
            let g:airline_powerline_fonts = 1
            let g:airline#extensions#tabline#enabled = 1
          '';
        }
        vim-nix
        ctrlp-vim
        vim-gitgutter
        vim-devicons
        {
          plugin = vim-startify;
          config = ''
            function! StartifyEntryFormat()
              return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
            endfunction
          '';
        }

        nerdtree
        vim-markdown
        haskell-vim
        fzf-vim
        {
          plugin = if config.isLinux then vim-xkbswitch else vim-xkbswitch-mac;
          config = ''
            let g:XkbSwitchEnabled = 1
          '';
        }
        {
          plugin = toggleterm-nvim;
          config = ''
            require("toggleterm").setup{
              open_mapping = [[<c-\>]],
              direction = "float",
              shade_terminals = true,
              shade_filetypes = { "none", "fzf" },
              float_opts = {
                border = "curved",
              },
            }
          '';
          type = "lua";
        }
      ];
  };
}
