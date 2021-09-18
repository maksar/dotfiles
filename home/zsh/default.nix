{ config, pkgs, home, ... }: {

  home.packages = [ pkgs.exa pkgs.zsh-powerlevel10k ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    envExtra = ''
      PATH=./bin/:$PATH
      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
    '';
          # ${if ("i686-linux" == pkgs.self.system) then ". /etc/profile.d/nix.sh" else ""}

    loginExtra = ''
      ${builtins.readFile ./.p10k.zsh}
    '';
    plugins = [{
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }];
    shellAliases = { ls = "exa -la --icons"; };

    oh-my-zsh = {
      enable = true;
      plugins = [ "z" ];
    };
  };
}
