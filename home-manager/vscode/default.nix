{ config, pkgs, ... }: {

  home.packages = [ pkgs.nixfmt pkgs.curl pkgs.jq ];

  programs.vscode = {
    enable = true;
    userSettings = {
      "editor.renderWhitespace" = "all";
      "files.autoSave" = "onFocusChange";
      "editor.rulers" = [ 80 120 ];
      "telemetry.enableTelemetry" = false;
      "telemetry.enableCrashReporter" = false;
      "editor.tabSize" = 2;
      "files.exclude" = { "**/node_modules/**" = true; };
      "editor.formatOnSave" = false;
      "breadcrumbs.enabled" = true;
      "editor.useTabStops" = false;
      "editor.fontFamily" = "PragmataPro Liga";
      "editor.fontSize" = 16;
      "editor.fontLigatures" = true;
      "editor.lineHeight" = 20;
      "workbench.fontAliasing" = "antialiased";
      "files.trimTrailingWhitespace" = true;
      "editor.minimap.enabled" = false;
      "workbench.colorTheme" = "Atom One Dark";
      "workbench.editor.enablePreview" = false;
      "workbench.iconTheme" = "vscode-icons-mac";
      "terminal.integrated.fontFamily" = "PragmataPro Liga";
      "haskell.serverExecutablePath" = "haskell-language-server";
      "files.watcherExclude" = { "**/*" = true; };
    };

    keybindings = [{
      key = "shift+cmd+d";
      command = "editor.action.copyLinesDownAction";
      when = "editorTextFocus && !editorReadonly";
    }];

    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace
      (import ./extensions.nix).extensions;
  };
}
