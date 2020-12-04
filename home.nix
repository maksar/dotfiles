{ config, pkgs, ... }:
{

  # TODO modularize
  imports = [
  ];

  home.packages = [
    pkgs.home-manager
    pkgs.tig

    pkgs.zsh-powerlevel10k
    pkgs.gitAndTools.delta
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BAT_PAGER = config.programs.bat.config.pager;
  };

  programs.man.enable = true;

  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./kitty.conf;
  };

  programs.git = {
    enable = true;
    userName = "Shestakov, Aleksandr";
    userEmail = "a.shestakov@itransition.com";
    package = pkgs.gitFull;
    extraConfig = {
      diff = {
        colorMoved = "default";
      };
    };
    aliases = {
      s = "status";
      co = "checkout";
      d = "diff";
      c = "commit";
      p = "pull";
      P = "push";
      b = "branch";
    };
    ignores = [ "*~" ".DS_Store" ];
    lfs = {
      enable = true;
    };
    delta = {
      enable = true;
      options = {
        line-numbers = true;
        side-by-side = true;
      };
    };
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      pager = "less -R";
    };
  };

  programs.autojump = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    envExtra = ''
      PATH=./bin/:$PATH
    '';
    loginExtra = ''
      ${builtins.readFile ./.p10k.zsh}
    '';
    plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
    ];
    shellAliases = {
      ls = "lsd -lah";
    };

    oh-my-zsh = {
      enable = true;
    };
  };

  programs.jq.enable = true;
  programs.htop.enable = true;
  programs.dircolors.enable = true;
  programs.fzf.enable = true;
  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
  };


  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    vimdiffAlias = true;
    configure = {
      customRC = ''
        set clipboard+=unnamedplus

        set termguicolors
        let g:airline_powerline_fonts = 1
        let g:rigel_airline = 0
        let g:airline_theme = 'rigel'
        colorscheme rigel


        set mouse=a


       :tnoremap <C-h> <C-\><C-N><C-w>h
       :tnoremap <C-j> <C-\><C-N><C-w>j
       :tnoremap <C-k> <C-\><C-N><C-w>k
       :tnoremap <C-l> <C-\><C-N><C-w>l
       :inoremap <C-h> <C-\><C-N><C-w>h
       :inoremap <C-j> <C-\><C-N><C-w>j
       :inoremap <C-k> <C-\><C-N><C-w>k
       :inoremap <C-l> <C-\><C-N><C-w>l
       :nnoremap <C-h> <C-w>h
       :nnoremap <C-j> <C-w>j
       :nnoremap <C-k> <C-w>k
       :nnoremap <C-l> <C-w>l


        " Use tab for trigger completion with characters ahead and navigate.
        " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
        " other plugin before putting this into your config.
        inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Use <c-space> to trigger completion.
        if has('nvim')
        inoremap <silent><expr> <c-space> coc#refresh()
        else
        inoremap <silent><expr> <c-@> coc#refresh()
        endif

        " Make <CR> auto-select the first completion item and notify coc.nvim to
        " format on enter, <cr> could be remapped by other vim plugin
        inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


                              " Use `[g` and `]g` to navigate diagnostics
        " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " GoTo code navigation.
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        " Use K to show documentation in preview window.
        nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

      '';
      packages.myVimPackage = with pkgs.vimPlugins;
      {
        start = [
            vim-airline
            vim-airline-themes
            ctrlp-vim
            vim-nix
            vim-gitgutter
            vim-startify
            coc-nvim
            fzf-vim

          ];
        };

        plug.plugins = [
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
