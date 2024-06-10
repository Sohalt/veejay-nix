{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages = rec {
        default = veejay-server;
        veejay-core = pkgs.callPackage ./veejay-core.nix {};
        veejay-server = pkgs.callPackage ./veejay-server.nix {inherit veejay-core;};
        veejay-client = pkgs.callPackage ./veejay-client.nix {inherit veejay-core;};
      };
    });
}
