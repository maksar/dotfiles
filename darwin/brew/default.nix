{
  homebrew.enable = true;
  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.lockfiles = false;
  homebrew.onActivation.upgrade = true;

  homebrew.taps = [
    "homebrew/cask-versions"
    "homebrew/cask-drivers"
  ];

  homebrew.brews = [
    # Browsers & network tools
    # "wireguard-tools"
  ];

  homebrew.casks = [
    # Drivers
    # "logitech-options"
    # "intel-power-gadget"
    # "menumeters"

    # Communication
    "skype"
    "slack"
    "viber"
    "telegram"
    "zoom"
    "microsoft-teams"
    "basecamp"
    # "mimestream"
    "whatsapp"
    "signal"

    # Utilities
    "dropbox"
    "1password"
    # "1password-cli-beta"
    "alfred"
    # "unshaky"
    "rectangle"
    "dash"
    "bitbar"
    "appzapper"

    # Browsers & network tools
    # "firefox"
    "google-chrome"
    # "brave-browser"
    # "vivaldi"
    # "safari-technology-preview"
    "transmission"
    # "tunnelbear"
    # "openvpn-connect"
    "tailscale"
    # "charles"

    # Developer tools
    # "sourcetree"
    # "typora"
    "caffeine"
    # "basecamp"

    # Media
    "steam"
    "vlc"
    # "kindle"
    # "send-to-kindle"
    "calibre"
    # "yt-music"
  ];
}
