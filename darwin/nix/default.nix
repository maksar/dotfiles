{ config, pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixUnstable;
  nix.useDaemon = true;
  nix.nixPath = [
    { darwin-config = "${config.environment.darwinConfig}"; }
    "$HOME/.nix-defexpr/channels"
  ];
  nix.trustedUsers = builtins.attrNames config.users.users;
  nix.gc.automatic = false;
  nix.extraOptions = ''
    gc-keep-derivations = true
    gc-keep-outputs = true
    experimental-features = nix-command flakes
  '';
  nix.buildCores = 6;
  nix.maxJobs = 6;
  nix.distributedBuilds = true;
  nix.buildMachines = [{
    hostName = "nix-docker";
    sshUser = "root";
    sshKey = "/etc/nix/docker_rsa";
    systems = [ "x86_64-linux" ];
    supportedFeatures = [ "big-parallel" ];
    maxJobs = 6;
    buildCores = 6;
  }
  # {
  #   hostName = "eu.nixbuild.net";
  #   sshUser = "root";
  #   sshKey = "/etc/nix/nixbuild.net";
  #   systems = [ "x86_64-linux" ];
  #   supportedFeatures = [ "big-parallel" "benchmark" ];
  #   maxJobs = 100;
  # }
    ];
  users.nix.configureBuildUsers = true;

  nix.binaryCachePublicKeys =
    [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
  nix.binaryCaches = [ "https://hydra.iohk.io" ];
}
