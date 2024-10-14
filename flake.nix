{
  description = "A highly awesome system configuration.";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix2vim.url = "github:gytis-ivaskevicius/nix2vim";
    # Had to comment this out for a bit
    nix2vim.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs @ {flake-parts, nix2vim, nixpkgs, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        # To import a flake module
        # 1. Add foo to inputs
        # 2. Add foo as a parameter to the outputs function
        # 3. Add here: foo.flakeModule
      ];
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.
        nixosConfigurations.nixos =
          nixpkgs.lib.nixosSystem
          {
            system = "x86_64-linux";
            modules = [
              ./configuration.nix
              ./hardware-configuration.nix
	      {
		nixpkgs.overlays = [
		  nix2vim.overlay
		];
	      }
            ];
          };
      };

      systems = ["x86_64-linux"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
        packages.default = pkgs.hello;
      };
    };
}
