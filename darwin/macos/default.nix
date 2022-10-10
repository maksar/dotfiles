{
  system.defaults.dock.autohide = true;
  system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
  system.defaults.trackpad.Clicking = true;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  system.activationScripts.keyboardLayout.text = ''
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array "<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>19458</integer><key>KeyboardLayout Name</key><string>RussianWin</string></dict>"
    defaults write com.apple.HIToolbox AppleGlobalTextInputProperties -dict TextInputGlobalPropertyPerContextInput -int 1
    defaults write -g AppleFontSmoothing -int 0
  '';
}
