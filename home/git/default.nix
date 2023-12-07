{ config, pkgs, ... }: {

  home.packages = [
    pkgs.tig
    pkgs.lazygit

    pkgs.gitAndTools.delta
    pkgs.diff-so-fancy
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
      gpg = { format = "ssh"; };
    };
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBkr9IPge4Egv4R0+74zynReNDtelevINHdxIw11s5ZW";
      signByDefault = true;
      gpgPath = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
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
    diff-so-fancy = {
      enable = true;
    };
    delta = {
      enable = false;
      options = {
        line-numbers = true;
        navigate = true;
      };
    };
  };
}
