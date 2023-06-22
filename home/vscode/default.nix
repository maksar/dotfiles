{ config, system, pkgs, lib, ... }:

  let
  extensions = [
    "2gua.rainbow-brackets"
    "4ops.terraform"
    "akamud.vscode-theme-onedark"
    "amazonwebservices.aws-toolkit-vscode"
    "bbenoist.nix"
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
    "wayou.vscode-icons-mac"
    "will-wow.vscode-alternate-file"
    "wingrunr21.vscode-ruby"
  ];
  in
{
  home.packages = [ pkgs.nixfmt pkgs.curl pkgs.jq ];

  programs.vscode = {
    enable = config.isDarwin;
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
      "editor.fontSize" = 18;
      "editor.fontLigatures" = true;
      "editor.lineHeight" = 20;
      "workbench.fontAliasing" = "antialiased";
      "files.trimTrailingWhitespace" = true;
      "editor.minimap.enabled" = false;
      "workbench.colorTheme" = "Atom One Dark";
      "workbench.editor.enablePreview" = false;
      "workbench.iconTheme" = "vscode-icons-mac";
      "terminal.integrated.fontFamily" = "PragmataPro Liga";
      "terminal.integrated.fontSize" = 18;
      "terminal.integrated.tabs.enabled" = false;
      "remote.SSH.defaultExtensions" = extensions;
      "editor.lineNumbers" = "on";
      "resmon.show.disk" = true;
      "resmon.disk.format" = "PercentUsed";
      "resmon.disk.drives" = ["/dev/root"];
      "yaml.customTags" = ["!reference sequence"];
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
    ];
  };

  home.activation.installExtensions =
    lib.hm.dag.entryAfter [ "writeBoundary" ]
      (lib.optionalString config.isDarwin (builtins.concatStringsSep "\n" (map (e: "${config.programs.vscode.package}/bin/code --install-extension ${e} --force") extensions)));
}
