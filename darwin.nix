{ config, pkgs, ... }:

rec {
  imports = [ ./darwin <home-manager/nix-darwin> ./projects ];

  mainUser = "maksar";

  users.users.${mainUser} = {
    home = "/Users/${mainUser}";
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  home-manager = {
    users.${mainUser} = import ./home-manager;
    useGlobalPkgs = true;
    useUserPackages = false;
  };
  environment.systemPackages =
    config.home-manager.users.${mainUser}.home.packages;

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin.nix";

  time.timeZone = "Europe/Minsk";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
