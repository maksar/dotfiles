{
  description = "LDAP-bot Flake";

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
              owner = "maksar";
              repo = "gamgee";
              rev = "34cc95b39abea22769d18993992e9aacbee07a22";
              sha256 = "0sabwdrppx90vk32ilnc7n89mjqqhnp3drqvbypy0cx7b1i90wcm";
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
          stack-sha256 = "00dkimffbzdcvnna8sm4rcq90bvhgy36y7mymmjpqnvigif1yvwm";
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
