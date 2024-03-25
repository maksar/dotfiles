{
  description = "Maksar Nix system configs, and some other useful stuff.";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/23.11";

    # Environment/system management
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Other sources
    comma.url = "github:DavHau/comma/flake";
    comma.inputs.nixpkgs.follows = "nixpkgs";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, darwin, home-manager, flake-utils, ... }@inputs:
    let
      # Configuration for `nixpkgs` mostly used in personal configs.
      nixpkgsConfig = with inputs; rec {
        config = { allowUnfree = true; };
        overlays = self.overlays ++ [
          (final: prev: rec {
            master = import nixpkgs-master {
              inherit (prev) system;
              inherit config;
            };
            unstable = import nixpkgs-unstable {
              inherit (prev) system;
              inherit config;
            };
            stable = import nixpkgs-stable {
              inherit (prev) system;
              inherit config;
            };

            # awscli2 = stable.awscli2;
          })
        ];
      };

      homeManagerCommonConfig = { imports = [ ./home ]; };

      # Modules shared by most `nix-darwin` personal configurations.
      nixDarwinCommonModules = [
        # Include extra `nix-darwin`
        self.darwinModules.users

        # Main `nix-darwin` config
        ./darwin

        # `home-manager` module
        home-manager.darwinModules.home-manager
        ({ config, lib, ... }:
          let inherit (config.users) primaryUser;
          in {
            nixpkgs = nixpkgsConfig;
            users.users.${primaryUser}.home = "/Users/${primaryUser}";
            home-manager.useGlobalPkgs = true;
            home-manager.users.${primaryUser} = homeManagerCommonConfig // {
              os = "darwin";
              dropboxEnabled = true;
            };
          })
      ];
    in {

      # Personal configuration ------------------------------------------------------------------- {{{

      # My `nix-darwin` configs
      darwinConfigurations = {
        # Mininal configuration to bootstrap systems
        bootstrap = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [ ./darwin/nix { nixpkgs = nixpkgsConfig; } ];
        };

        # Config with small modifications needed/desired for CI with GitHub workflow
        githubCI = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = nixDarwinCommonModules ++ [
            ({ lib, ... }: {
              users.primaryUser = "runner";
              homebrew.enable = lib.mkForce false;
              dropboxEnabled = false;
            })
          ];
        };

        # My macOS main laptop config
        macbook = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = nixDarwinCommonModules ++ [{
            users.primaryUser = "maksar";
            networking.computerName = "Maksar 💻";
            networking.hostName = "MaksarBookPro";
          }];
        };
      };

      # Build and activate with `nix build .#cloudVM.activationPackage; ./result/activate`
      cloudVM = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs ( nixpkgsConfig // {
          system = "x86_64-linux";
          # ; # { allowUnfree = true; };
        });

        modules = [
          homeManagerCommonConfig
          {
            os = "linux";
            home.username = "maksar";
            home.homeDirectory = "/home/maksar";
            dropboxEnabled = false;
          }
        ];
      };

      overlays = with inputs;
        [
          (final: prev: {
            # Some packages
            comma = import comma { inherit (prev) pkgs; };
          })
        ];

      # My `nix-darwin` modules that are pending upstream, or patched versions waiting on upstream fixes.
      darwinModules = {
        users = import ./modules/darwin/users.nix;
      };
    };
}
