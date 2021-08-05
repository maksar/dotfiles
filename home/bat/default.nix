{ config, pkgs, ... }: {
  home.sessionVariables = {
    EDITOR = "nvim";
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
