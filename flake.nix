{
  description = "Nebilam's NixOS config with flakes";

  inputs = {
  
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
    	url = "github:nix-community/home-manager/release-24.05";
    	inputs.nixpkgs.follows = "nixpkgs";
   	};
   	
    # Hardware Configuration
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      # inherit (self) outputs;
      # stateVersion = "23.05"; # FIXME not necessary because never changes (can be hardcoded)
      myLib = import ./lib { 
        inherit (nixpkgs) lib; 
        # inherit pkgs;
        inherit inputs;
        inherit (inputs) home-manager;
        # inherit stateVersion; 
        };
    in
    
    {
      nixosConfigurations = { 
        gamingpc = myLib.custom.mkHost {
          hostname = "gamingpc";
          username = "nebilam";
          desktop = "gnome";
        };
    };
    };
}
