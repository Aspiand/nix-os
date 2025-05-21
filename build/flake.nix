{
  description = "NixOS for hg680p";
  inputs = {
    nipkgs.url = "nixpkgs/nixos-24.11-small";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-generators,
      ...
    }:
    {
      packages.aarch64-linux = {
        sdcard = nixos-generators.nixosGenerate {
          system = "aarch64-linux";
          format = "sd-aarch64";
          modules = [ ./configuration.nix ];
        };
      };
    };
}
