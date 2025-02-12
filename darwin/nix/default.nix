{ config, pkgs, ... }: {

  services.nix-daemon.enable = true;
  nix.package = pkgs.nixVersions.latest;
  nix.useDaemon = true;
  nix.settings = {
    trusted-users = ["maksar"];
    cores = 6;
    max-jobs = 1;
    substituters = [ "https://nix-cache.fairy-mercat.ts.net" ];

    trusted-public-keys =
    [
      "soostone.com-1:HH1l8F1W1Wt4xW7LBVj3dBlesomw5Qscl66upQkvPMk="
    ];

  };
  ids.gids.nixbld = 30000;
  nix.gc.automatic = false;
  nix.extraOptions = ''
    gc-keep-derivations = true
    gc-keep-outputs = true
    experimental-features = nix-command flakes
  '';
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
  nix.configureBuildUsers = true;

  programs.zsh.enable = true;
}
