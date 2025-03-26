{
  description = "NixOS-based router framework";

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;}
    (
      {
        config,
        self,
        ...
      }: let
        flakeModules = {
          lib = import ./modules/flake/lib.nix {inherit inputs;};
          modules = import ./modules/flake/modules.nix {inherit config self inputs;};
          partitions = import ./modules/flake/partitions/partitions.nix;
          systems = import ./modules/flake/systems.nix;
        };
      in {
        imports = [
          flake-parts.flakeModules.modules
          flake-parts.flakeModules.partitions
          flakeModules.lib
          flakeModules.partitions
          flakeModules.systems
          flakeModules.modules
        ];

        flake = {
          inherit flakeModules;
        };
      }
    );

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    eris = {
      url = "github:TahlonBrahic/eris";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixpkgs.url = "github:/nixos/nixpkgs/nixos-24.11";
  };
}
