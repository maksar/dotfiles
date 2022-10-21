{ config, pkgs, ... }: {

  home.packages = [
    pkgs.tig
    pkgs.lazygit

    pkgs.gitAndTools.delta
  ];

  programs.git = {
    enable = true;
    userName = "Shestakov Alex";
    userEmail = "Maksar.mail@gmail.com";
    package = pkgs.gitFull;
    extraConfig = {
      diff = { colorMoved = "default"; };
      pull = { rebase = "true"; };
      rebase = { autoStash = "true"; };
      push = { autoSetupRemote = "true"; };
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
    lfs = { enable = true; };
    delta = {
      enable = true;
      options = {
        line-numbers = true;
        navigate = true;
      };
    };
  };
}
