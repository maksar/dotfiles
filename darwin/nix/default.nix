{ config, pkgs, ... }: {

  services.nix-daemon.enable = true;
  nix.package = pkgs.nixUnstable;
  nix.useDaemon = true;
  nix.trustedUsers = builtins.attrNames config.users.users;
  nix.gc.automatic = false;
  nix.extraOptions = ''
    gc-keep-derivations = true
    gc-keep-outputs = true
    experimental-features = nix-command flakes
  '';
  nix.buildCores = 6;
  nix.maxJobs = 2;
  # nix.distributedBuilds = true;
  # nix.buildMachines = [{
  #   hostName = "nix-docker";
  #   sshUser = "root";
  #   sshKey = "/etc/nix/docker_rsa";
  #   systems = [ "x86_64-linux" ];
  #   supportedFeatures = [ "big-parallel" ];
  #   maxJobs = 6;
  #   buildCores = 6;
  # }
  # {
  #   hostName = "eu.nixbuild.net";
  #   sshUser = "root";
  #   sshKey = "/etc/nix/nixbuild.net";
  #   systems = [ "x86_64-linux" ];
  #   supportedFeatures = [ "big-parallel" "benchmark" ];
  #   maxJobs = 100;
  # }
    # ];
  users.nix.configureBuildUsers = true;

  nix.binaryCachePublicKeys =
    [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];
  nix.binaryCaches = [ "https://cache.nixos.org" "https://hydra.iohk.io" "https://maksar.cachix.org" ];

  programs.zsh.enable = true;
}
