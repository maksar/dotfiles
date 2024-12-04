{ config, pkgs, ... }:

let
  allowed_signers_path = "git/allowed_signers";
  soostone_config_path = "git/soostone";
  name = "Shestakov Alex";
  main_email = "Maksar.mail@gmail.com";
  main_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBkr9IPge4Egv4R0+74zynReNDtelevINHdxIw11s5ZW";
  soostone_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJI8lcAEK45B7MmJcCDPBv1x0Q1Kvezbxxz7SSDHhaav";
  soostone_email = "alexander.shestakov@soostone.com";
in
{
  home.packages = [
    pkgs.tig

    pkgs.gitAndTools.delta
    pkgs.diff-so-fancy
    pkgs._1password-cli
  ];

  xdg.configFile = {
    ${allowed_signers_path} = {
      text = ''
        ${main_email} ${main_public_key}
        ${soostone_email} ${soostone_public_key}
      '';
    };

    ${soostone_config_path} = {
      text = ''
        [user]
          name = "${name}"
          email = "${soostone_email}"
          signingkey = "${soostone_public_key}"
      '';
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui.nerdFontsVersion = "3";
      gui.showIcons = false;
      git.pull.mode = "rebase";
    };
  };

  programs.git = {
    enable = true;
    userName = name;
    userEmail = main_email;
    package = pkgs.gitFull;
    extraConfig = {
      diff = { colorMoved = "default"; };
      pull = { rebase = "true"; };
      rebase = { autoStash = "true"; };
      push = { autoSetupRemote = "true"; };
      gpg = { format = "ssh"; ssh = { allowedSignersFile = "${config.home.homeDirectory}/.config/${allowed_signers_path}"; }; };
    };
    includes = [
      {
        condition = "gitdir:${config.home.homeDirectory}/projects/soostone/";
        path = "${config.home.homeDirectory}/.config/${soostone_config_path}";
      }
    ];
    signing = {
      key = main_public_key;
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
