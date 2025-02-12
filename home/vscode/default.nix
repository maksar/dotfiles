{ config, system, pkgs, lib, ... }:

  let
  extensions = [
    "4ops.terraform"
    "akamud.vscode-theme-onedark"
    "amazonwebservices.aws-toolkit-vscode"
    "bibhasdn.unique-lines"
    "brettm12345.nixfmt-vscode"
    "bung87.rails"
    "bung87.vscode-gemfile"
    "cweijan.dbclient-jdbc"
    "dbankier.vscode-quick-select"
    "deerawan.vscode-dash"
    "donjayamanne.githistory"
    "eamodio.gitlens"
    "fabiospampinato.vscode-commands"
    "ginfuru.ginfuru-vscode-jekyll-syntax"
    "ginfuru.vscode-jekyll-snippets"
    "GitHub.copilot"
    "hashicorp.terraform"
    "haskell.haskell"
    "hoovercj.haskell-linter"
    "iliazeus.vscode-ansi"
    "ilyakooo0.ormolu"
    "jameswain.gitlab-pipelines"
    "janw4ld.lambda-black"
    "jnoortheen.nix-ide"
    "johnpapa.vscode-peacock"
    "justusadam.language-haskell"
    "luggage66.AWK"
    "mhutchie.git-graph"
    "mkhl.direnv"
    "mogeko.haskell-extension-pack"
    "ms-vscode-remote.vscode-remote-extensionpack"
    "mutantdino.resourcemonitor"
    "oderwat.indent-rainbow"
    "Shopify.ruby-lsp"
    "shinichi-takii.sql-bigquery"
    "sianglim.slim"
    "streetsidesoftware.code-spell-checker"
    "syler.sass-indented"
    "tal7aouy.icons"
    "tomoki1207.pdf"
    "usernamehw.errorlens"
    "vigoo.stylish-haskell"
    "will-wow.vscode-alternate-file"
    "wingrunr21.vscode-ruby"
  ];
  in
{
  home.packages = with pkgs; [ nixfmt-classic curl jq jqp nil ];

  programs.vscode = {
    enable = config.isDarwin;
    userSettings = {
      "breadcrumbs.enabled" = true;
      "editor.fontFamily" = "PragmataPro Liga";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 16.5;
      "editor.formatOnSave" = false;
      "editor.lineHeight" = 18;
      "editor.lineNumbers" = "on";
      "editor.minimap.enabled" = false;
      "editor.renderWhitespace" = "all";
      "editor.rulers" = [ 80 120 ];
      "editor.tabSize" = 2;
      "editor.useTabStops" = false;
      "files.autoSave" = "onFocusChange";
      "files.exclude" = { "**/node_modules/**" = true; };
      "files.trimTrailingWhitespace" = true;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "remote.SSH.defaultExtensions" = extensions;
      "remote.SSH.useExecServer" = false;
      "resmon.disk.drives" = ["/dev/root"];
      "resmon.disk.format" = "PercentUsed";
      "resmon.show.disk" = true;
      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;
      "terminal.integrated.fontFamily" = "Pragmasevka Nerd Font";
      "terminal.integrated.fontSize" = 16.5;
      "terminal.integrated.tabs.enabled" = false;
      "terminal.integrated.scrollback" = 10000;
      "window.zoomLevel" = 1;
      "workbench.colorTheme" = "Lambda Dark+";
      "workbench.editor.enablePreview" = false;
      "workbench.fontAliasing" = "antialiased";
      "workbench.iconTheme" = "icons";
      "yaml.customTags" = ["!reference sequence"];
      "window.commandCenter" = false;
      "editor.accessibilitySupport" = "off";

      "editor.stickyScroll.enabled" =  true;
      "editor.cursorSmoothCaretAnimation" = "on";
      "workbench.tree.enableStickyScroll" =  true;
      "terminal.integrated.stickyScroll.enabled" =  true;
      "window.zoomPerWindow" =  true;

      "window.confirmBeforeClose" = "keyboardOnly";

      "commands.commands" = {
        "setAndFormatJson" = {
          "sequence" = [
            {
              "command" = "commands.setEditorLanguage";
              "args" = "json";
            }
            {
              "command" = "editor.action.formatDocument";
            }
          ];

        };
      };

      "cSpell.userWords" = [
        "widengle"
        "cicd"
        "cdag"
        "mlflow"
        "soostone"
        "pkgs"
        "nixpkgs"
        "maksar"
        "shestakov"
      ];
    };

    keybindings = [
      {
        "key" = "F2";
        "command"= "workbench.action.toggleMaximizedPanel";
      }
      {
        key = "f9";
        command = "editor.action.showDefinitionPreviewHover";
        when = "editorTextFocus";
      }
      {
        key = "shift+cmd+d";
        command = "editor.action.copyLinesDownAction";
        when = "editorTextFocus && !editorReadonly";
      }
      {
        key = "shift+cmd+]";
        command = "workbench.action.terminal.focusNextPane";
        when = "terminalFocus";
      }
      {
        key = "shift+cmd+[";
        command = "workbench.action.terminal.focusPreviousPane";
        when = "terminalFocus";
      }
      {
        key = "shift+cmd+i";
        command = "runCommands";
        args = {
          commands = ["setAndFormatJson"];
        };
      }
    ];
  };

  # home.activation.installExtensions =
  #   lib.hm.dag.entryAfter [ "writeBoundary" ]
  #     (lib.optionalString config.isDarwin (builtins.concatStringsSep "\n" (map (e: "${config.programs.vscode.package}/bin/code --install-extension ${e} --force") extensions)));
  home.activation.updateExtensions =
    lib.hm.dag.entryAfter [ "writeBoundary" ]
      (lib.optionalString config.isDarwin "${config.programs.vscode.package}/bin/code --update-extensions");
}
