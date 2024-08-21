{ config, pkgs, home, ... }: {

  home.packages = [ pkgs.eza pkgs.zsh-powerlevel10k ];

  programs.atuin = {
    enable = true;
    flags = ["--disable-up-arrow"];
    settings = {
      ctrl_n_shortcuts = true;
      # enter_accept = true;
      style = "compact";
      show_help = false;
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    initExtraBeforeCompInit = ''
    # $PWD/result*/bin
      for i in ''${(s/:/)PATH} ; do
        test -d ''${i}/../share/zsh/vendor-completions && fpath+=(''${i}/../share/zsh/vendor-completions)
        test -d ''${i}/../share/zsh/site-functions && fpath+=(''${i}/../share/zsh/site-functions)
      done
    '';
    syntaxHighlighting.enable = true;
    envExtra = ''
      PATH=./bin/:$PATH
      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
      ${builtins.readFile ./.p10k.zsh}
      ${if config.isLinux then ". /etc/profile.d/nix.sh" else ""}
    '';

    loginExtra = ''
      ${builtins.readFile ./.p10k.zsh}
    '';
    plugins = [{
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }
    ];
    shellAliases = {
      ls = "eza -la --icons";
      j = "just build";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "z" "terraform" ];
    };
  };
}
