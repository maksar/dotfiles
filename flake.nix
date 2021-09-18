{
  description = "Maksar’s Nix system configs, and some other useful stuff.";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixos-stable.url = "github:nixos/nixpkgs/nixos-21.05";

    # Environment/system management
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Other sources
    comma = { url = "github:Shopify/comma"; flake = false; };

    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
    flake-utils.url = "github:numtide/flake-utils";

    prefmanager.url = "github:malob/prefmanager";
    prefmanager.inputs.nixpkgs.follows = "nixpkgs";

    envy = { url = "github:Shados/envy"; flake = false; };
  };

  outputs = { self, nixpkgs, darwin, home-manager, flake-utils, envy, ... }@inputs:
  let
    # Configuration for `nixpkgs` mostly used in personal configs.
    nixpkgsConfig = with inputs; rec {
      config = { allowUnfree = true; };
      overlays = self.overlays ++ [
        (
          final: prev: {
            master = import nixpkgs-master { inherit (prev) system; inherit config; };
            unstable = import nixpkgs-unstable { inherit (prev) system; inherit config; };

            # Packages I want on the bleeding edge
            kitty = final.unstable.kitty;
            nixUnstable = final.unstable.nixUnstable;
          }
        )
      ];
    };

    homeManagerCommonConfig = with self.homeManagerModules; {
      imports = [
        ./home
        vim-envy
      ];
    };

    # Modules shared by most `nix-darwin` personal configurations.
    nixDarwinCommonModules = [
      # Include extra `nix-darwin`
      self.darwinModules.security.pam
      self.darwinModules.users
      self.darwinModules.mysql
      self.darwinModules.mongodb

      # Main `nix-darwin` config
      ./darwin

      # `home-manager` module
      home-manager.darwinModules.home-manager
      ( { config, lib, ... }: let inherit (config.users) primaryUser; in {
        nixpkgs = nixpkgsConfig;
        users.users.${primaryUser}.home = "/Users/${primaryUser}";
        home-manager.useGlobalPkgs = true;
        home-manager.users.${primaryUser} = homeManagerCommonConfig;
      })
    ];
  in {

    # Personal configuration ------------------------------------------------------------------- {{{

    # My `nix-darwin` configs
    darwinConfigurations = {
      # Mininal configuration to bootstrap systems
      bootstrap = darwin.lib.darwinSystem {
        modules = [ ./darwin/nix { nixpkgs = nixpkgsConfig; } ];
      };

      # Config with small modifications needed/desired for CI with GitHub workflow
      githubCI = darwin.lib.darwinSystem {
        modules = nixDarwinCommonModules ++ [
          ({ lib, ... }: {
            users.primaryUser = "runner";
            homebrew.enable = lib.mkForce false;
          })
        ];
      };

      # My macOS main laptop config
      macbook = darwin.lib.darwinSystem {
        modules = nixDarwinCommonModules ++ [
          {
            users.primaryUser = "maksar";
            networking.computerName = "Maksar’s 💻";
            networking.hostName = "MaksarBookPro";
          }
        ];
      };
    };

    # Config I use with Linux cloud VMs
    # Build and activate with `nix build .#cloudVM.activationPackage; ./result/activate`
    cloudVM = home-manager.lib.homeManagerConfiguration {
      system = "x86_64-linux";
      stateVersion = "21.05";
      homeDirectory = "/home/maksar";
      username = "maksar";
      configuration = {
        imports = [ homeManagerCommonConfig ];
        nixpkgs = nixpkgsConfig;
      };
    };

    overlays = with inputs; [
      (
        final: prev: {
          # Some packages
          comma = import comma { inherit (prev) pkgs; };
          prefmanager = prefmanager.defaultPackage.${prev.system};
        }
      )
    ];

    # My `nix-darwin` modules that are pending upstream, or patched versions waiting on upstream fixes.
    darwinModules = {
      security.pam = import ./modules/darwin/pam.nix;
      users = import ./modules/darwin/users.nix;
      mysql = import ./modules/darwin/mysql.nix;
      mongodb = import ./modules/darwin/mongodb.nix;
    };

    homeManagerModules = {
      vim-envy = import "${envy}/home-manager.nix" {};
    };
  } // flake-utils.lib.eachDefaultSystem (system: {
      legacyPackages = import nixpkgs { inherit system; inherit (nixpkgsConfig) config overlays; };
  });}
