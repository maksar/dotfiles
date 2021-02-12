{ config, pkgs, ... }: {
  home.sessionVariables = {
    EDITOR = "nvim";
    # EDITOR1 = config.home.username;
    # EDITOR1 = builtins.toString (builtins.attrNames config.home-manager.users);
    BAT_PAGER = config.programs.bat.config.pager;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      pager = "less -R";
    };
  };
}
