{
  description = "Maksar Nix system configs, and some other useful stuff.";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/master";

    # Environment/system management
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Other sources
    comma.url = "github:DavHau/comma/flake";
    comma.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, darwin, home-manager, flake-utils, ... }@inputs:
    let
      nixpkgsConfig = {
        config = { allowUnfree = true; };
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
        # Minimal configuration to bootstrap systems
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
            system.stateVersion = 5;
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
