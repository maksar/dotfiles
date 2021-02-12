{ config, pkgs, ... }: {

  home.packages = [
    pkgs.tig

    pkgs.gitAndTools.delta
  ];
  programs.git = {
    enable = true;
    userName = "Shestakov, Aleksandr";
    userEmail = "a.shestakov@itransition.com";
    package = pkgs.gitFull;
    extraConfig = { diff = { colorMoved = "default"; }; };
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
    lfs = { enable = true; };
    delta = {
      enable = true;
      options = {
        line-numbers = true;
        side-by-side = true;
      };
    };
  };
}
