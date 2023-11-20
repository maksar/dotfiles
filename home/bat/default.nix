{ config, pkgs, ... }: {
  home.sessionVariables = {
    EDITOR = "vim";
    BAT_PAGER = config.programs.bat.config.pager;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      pager = "less -R";
      style = "header,grid";
    };
  };
}
