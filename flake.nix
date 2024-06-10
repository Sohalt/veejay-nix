{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [self.overlays.default];
      };
    in
      {
        packages = {inherit (pkgs) veejay-core veejay-server veejay-client;};
        apps = rec {
          default = veejay-server;
          veejay-server = {
            type = "app";
            program = "${pkgs.veejay-server}/bin/veejay";
          };
          veejay-client = {
            type = "app";
            program = "${pkgs.veejay-client}/bin/reloaded";
          };
        };
      })
      // {
        overlays.default = final: prev: rec {
          default = veejay-server;
          veejay-core = final.callPackage ./veejay-core.nix {};
          veejay-server = final.callPackage ./veejay-server.nix {};
          veejay-client = final.callPackage ./veejay-client.nix {};
        };
      };
}
