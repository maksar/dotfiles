{
  description = "Gamgee Flake";

  inputs = {
    flake-utils = { url = "github:numtide/flake-utils"; };

    nixpkgs = { url = "github:NixOS/nixpkgs/master"; };

    haskell-nix = {
      url = "github:hackworthltd/haskell.nix/flake-fixes";
      inputs = { nixpkgs = { follows = "nixpkgs"; }; };
    };
  };

  outputs = { self, flake-utils, nixpkgs, haskell-nix }:
    flake-utils.lib.eachSystem (builtins.attrNames haskell-nix.legacyPackages)
    (system:
      with haskell-nix.legacyPackages.${system};
      let
        compiler-nix-name = "ghc883";

        project = pkgs.haskell-nix.project {
          inherit compiler-nix-name;
          src = pkgs.stdenv.mkDerivation {
            name = "source";
            src = pkgs.fetchFromGitHub {
              owner = "rkaippully";
              repo = "gamgee";
              rev = "bd15030fd385ef5b271c372afb8c0fd22848b7f8";
              sha256 = "sha256-lXGQYlinM+CvXxvnNq6FGMuakD3M0ijG3CD1e3PjS2k=";
            };
            buildPhase = ''
              mkdir $out
              cp -r $src/* $out
              cd  $out
              make gen-files
            '';
            installPhase = "true";
            buildInputs = [ pkgs.dhall-json ];
          };
          stack-sha256 = "sha256-lW8fXHxxW3xlrb4eb4Z/cC+QMMukaqSs3az95VyNswE=";
          materialized = ./materialized;
        };
      in rec {
        defaultApp = {
          type = "app";
          program = "${defaultPackage}/bin/gamgee";
        };

        defaultPackage = project.gamgee.components.exes.gamgee;
      });
}
