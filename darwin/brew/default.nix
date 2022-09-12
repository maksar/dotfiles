{
  homebrew.enable = true;
  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.lockfiles = false;
  homebrew.onActivation.upgrade = true;

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-versions"
    "homebrew/cask-drivers"
  ];

  homebrew.casks = [
    # Drivers
    "logitech-options"
    "intel-power-gadget"
    "menumeters"

    # Communication
    "skype"
    "slack"
    "viber"
    "telegram"
    "zoom"
    "microsoft-teams"
    "basecamp"
    "mimestream"
    "whatsapp"

    # Utilities
    "dropbox"
    "1password"
    "1password-cli"
    "alfred"
    "unshaky"
    "rectangle"
    "dash"
    "bitbar"

    # Browsers & network tools
    "firefox"
    "google-chrome"
    "brave-browser"
    "vivaldi"
    "safari-technology-preview"
    "transmission"
    "tunnelbear"
    "openvpn-connect"
    "charles"

    # Developer tools
    "sourcetree"
    "typora"
    "caffeine"
    "basecamp"

    # Media
    "steam"
    "vlc"
    "kindle"
    "send-to-kindle"
    "calibre"
    "yt-music"
  ];
}
