{
  homebrew.enable = true;
  homebrew.autoUpdate = true;
  homebrew.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.noLock = true;

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-versions"
    "homebrew/cask-drivers"
    "microsoft/mssql-release"
    "rkaippully/tools"
    # "homebrew/cask-fonts"
    # "homebrew/core"
    # "homebrew/services"
  ];

  environment.variables = {
    HOMEBREW_NO_ENV_FILTERING = "1";
    HOMEBREW_ACCEPT_EULA = "Y";
    ACCEPT_EULA = "Y";
  };

  homebrew.brews = [
    # MSSQL connection drivers
    "unixodbc"
    "msodbcsql17"

    "nmap" # version in nixos doesn't work with big sur
    "gamgee"
  ];

  homebrew.casks = [
    # Drivers
    "logitech-options"

    # Communication
    "skype"
    "slack"
    "viber"
    "telegram"
    "zoom"
    "microsoft-teams"
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
    "sourcetree"
    "charles"
    "jetbrains-toolbox"
    "typora"

    # Media
    "steam"
    "vlc"

    "postman"

    # "basecamp"
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
