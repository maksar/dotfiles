let
  nix-pre-commit-hooks = import (builtins.fetchTarball
    "https://github.com/cachix/pre-commit-hooks.nix/tarball/master");
in {
  pre-commit-check = nix-pre-commit-hooks.run {
    src = ./.;
    hooks = {
      vscode = {
        enable = true;
        name = "vscode";
        entry = "./home-manager/vscode/update.sh";
        pass_filenames = false;

        raw = {
          always_run = true;
          stages = [ "manual" ];
        };
      };

      nixfmt = { enable = true; };
    };
  };
}
