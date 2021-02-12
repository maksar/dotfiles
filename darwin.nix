{ config, pkgs, ... }:

let username = "maksar";
in {
  imports = [ ./darwin <home-manager/nix-darwin> ./projects ];

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  home-manager = {
    users.${username} = import ./home-manager;
    useGlobalPkgs = true;
    useUserPackages = false;
  };
  environment.systemPackages =
    config.home-manager.users.${username}.home.packages;

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin.nix";

  time.timeZone = "Europe/Minsk";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
