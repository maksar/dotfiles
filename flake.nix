{
  description = "Macbook Flake.";

  inputs.pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, pre-commit-hooks, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: {
      checks = {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
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
      };
      devShell = nixpkgs.legacyPackages.${system}.mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
      };
    });
}
