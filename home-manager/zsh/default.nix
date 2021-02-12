{ config, pkgs, home, ... }:
{

  home.packages = [ pkgs.lsd pkgs.zsh-powerlevel10k ];

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    envExtra = ''
      PATH=./bin/:$PATH
    '';
    loginExtra = ''
      ${builtins.readFile ./.p10k.zsh}
    '';
    plugins = [{
      name = "powerlevel10k";
      src = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }];
    shellAliases = { ls = "lsd -lah"; };

    oh-my-zsh = { enable = true; };
  };
}