{ config, system, pkgs, lib, ... }:

  let
  extensions = [
    "2gua.rainbow-brackets"
    "4ops.terraform"
    "akamud.vscode-theme-onedark"
    "amazonwebservices.aws-toolkit-vscode"
    "jnoortheen.nix-ide"
    "bibhasdn.unique-lines"
    "brettm12345.nixfmt-vscode"
    "bung87.rails"
    "bung87.vscode-gemfile"
    "dbankier.vscode-quick-select"
    "deerawan.vscode-dash"
    "donjayamanne.githistory"
    "eamodio.gitlens"
    "ginfuru.ginfuru-vscode-jekyll-syntax"
    "ginfuru.vscode-jekyll-snippets"
    "hashicorp.terraform"
    "haskell.haskell"
    "hoovercj.haskell-linter"
    "jameswain.gitlab-pipelines"
    "johnpapa.vscode-peacock"
    "justusadam.language-haskell"
    "mechatroner.rainbow-csv"
    "mhutchie.git-graph"
    "mkhl.direnv"
    "mogeko.haskell-extension-pack"
    "ms-vscode-remote.vscode-remote-extensionpack"
    "mutantdino.resourcemonitor"
    "oderwat.indent-rainbow"
    "rebornix.ruby"
    "shinichi-takii.sql-bigquery"
    "sianglim.slim"
    "streetsidesoftware.code-spell-checker"
    "syler.sass-indented"
    "tomoki1207.pdf"
    "usernamehw.errorlens"
    "vigoo.stylish-haskell"
    "tal7aouy.icons"
    "will-wow.vscode-alternate-file"
    "wingrunr21.vscode-ruby"
    "janw4ld.lambda-black"
    "ilyakooo0.ormolu"
    "fabiospampinato.vscode-commands"
  ];
  in
{
  home.packages = with pkgs; [ nixfmt curl jq nil ];

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
      "resmon.disk.drives" = ["/dev/root"];
      "resmon.disk.format" = "PercentUsed";
      "resmon.show.disk" = true;
      "telemetry.enableCrashReporter" = false;
      "telemetry.enableTelemetry" = false;
      "terminal.integrated.fontFamily" = "PragmataPro Liga";
      "terminal.integrated.fontSize" = 16.5;
      "terminal.integrated.tabs.enabled" = false;
      "window.zoomLevel" = 1;
      "workbench.colorTheme" = "Lambda Dark+";
      "workbench.editor.enablePreview" = false;
      "workbench.fontAliasing" = "antialiased";
      "workbench.iconTheme" = "icons";
      "yaml.customTags" = ["!reference sequence"];

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
    };

    keybindings = [
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
        command = "workbench.action.terminal.focusPreviousPane";
        when = "terminalFocus";
      }
    ];
  };

  home.activation.installExtensions =
    lib.hm.dag.entryAfter [ "writeBoundary" ]
      (lib.optionalString config.isDarwin (builtins.concatStringsSep "\n" (map (e: "${config.programs.vscode.package}/bin/code --install-extension ${e} --force") extensions)));
}
