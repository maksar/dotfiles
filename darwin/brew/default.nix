{

  imports = [
    ./brew.nix
  ];

  homebrew.enable = true;
  homebrew.autoUpdate = true;
  homebrew.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.noLock = true;

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-versions"
    # "homebrew/cask-drivers"
    # "homebrew/cask-fonts"
    # "homebrew/core"
    # "homebrew/services"
  ];

  homebrew.brews = [ "nmap" ]; # version in nixos doesn't work with big sur

  homebrew.casks = [
    "skype"
    "telegram-desktop"
    "dropbox"
    "1password"
    "unshaky"
    "openvpn-connect"
    "firefox"
    "google-chrome"
    "alfred"
    "zoom"
    "docker"
    "sourcetree"
    "charles"
    "virtualbox"
    "jetbrains-toolbox"
    "safari-technology-preview"
    "vivaldi"
    "steam"
    "slack"
  ];
  homebrew.masApps = {
    "XCode" = 497799835;
    "Amphetamine" = 937984704;
    "Excel" = 462058435;
    "Word" = 462054704;
    "Pages" = 409201541;
  };
}
