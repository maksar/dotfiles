{ config, pkgs, ... }:

let
  allowed_signers_path = "git/allowed_signers";
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBkr9IPge4Egv4R0+74zynReNDtelevINHdxIw11s5ZW";
in
rec {
  home.packages = [
    pkgs.tig
    pkgs.lazygit

    pkgs.gitAndTools.delta
    pkgs.diff-so-fancy
    pkgs._1password
  ];

  xdg.configFile = {
    ${allowed_signers_path} = {
      text = "${programs.git.userEmail} ${public_key}";
    };
  };

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
      gpg = { format = "ssh"; ssh = { allowedSignersFile = "${config.home.homeDirectory}/.config/${allowed_signers_path}"; }; };
    };
    signing = {
      key = public_key;
      signByDefault = true;
    } // (if config.isLinux then {} else { gpgPath ="/Applications/1Password.app/Contents/MacOS/op-ssh-sign"; });
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
