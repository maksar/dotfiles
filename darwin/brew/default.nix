{
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

  homebrew.brews = [
    "nmap" # version in nixos doesn't work with big sur
  ];

  homebrew.casks = [
    # Communication
    "skype"
    "slack"
    "viber"
    "telegram"
    "zoom"
    "miro"

    # Utilities
    "dropbox"
    "1password"
    "alfred"
    "unshaky"

    # Browsers & network tools
    "openvpn-connect"
    "firefox"
    "google-chrome"
    "vivaldi"
    "safari-technology-preview"
    "transmission"
    "tunnelbear"

    # Developer tools
    "docker"
    "sourcetree"
    "charles"
    "virtualbox"
    "jetbrains-toolbox"
    "typora"
    "fvim"

    # Media
    "steam"
    "vlc"

    "postman"
  ];
  homebrew.masApps = {
    "XCode" = 497799835;
    "Amphetamine" = 937984704;

    # Microsoft
    "Excel" = 462058435;
    "Word" = 462054704;
    "PowerPoint" = 462062816;
    "RemoteDesktop" = 1295203466;

    # Apple
    "Pages" = 409201541;
  };
}
