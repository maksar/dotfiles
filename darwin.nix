{ config, pkgs, ... }:

let
liga-iosevka = pkgs.stdenv.mkDerivation rec {
  pname = "liga-iosevka";
  version = "2.2.1";

  src = pkgs.fetchzip {
    url = "https://github.com/be5invis/Iosevka/files/3388580/${pname}-${version}.zip";
    sha256 = "sha256-D3tQJwEx0Ft5cZ/axIHYV+4OYcrL8ngZiWlGipj3tU8=";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    install -m644 ${pname}-${version}/*.ttf $out/share/fonts/
  '';
};
in
{

  imports = [
    <home-manager/nix-darwin>
    ./projects
  ];

  users.users."a.shestakov" = {
    home = "/Users/a.shestakov";
    shell = pkgs.zsh;
  };
  home-manager.users."a.shestakov" = import ./home.nix;
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;

  environment.systemPackages = config.home-manager.users."a.shestakov".home.packages;


  programs.zsh.enable = true;
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nixUnstable;
  nix.useDaemon = true;
  nix.nixPath = [{ darwin-config = "${config.environment.darwinConfig}"; } "$HOME/.nix-defexpr/channels"];
  nix.trustedUsers = [ "a.shestakov" ];
  # nix.gc.automatic = true;
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
    supportedFeatures = ["big-parallel"];
    maxJobs = 6;
    buildCores = 6;
  }];

  time.timeZone = "Europe/Minsk";

  system.defaults.dock.autohide = true;

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      powerline-fonts
      liga-iosevka
      monoid
      (nerdfonts.override {
        fonts = [ "Iosevka" ];
      })
    ];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
