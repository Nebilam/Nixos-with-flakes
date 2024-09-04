{ inputs, stateVersion, ... }: 
let
  lib = inputs.nixpkgs.lib;

  myLib = import ./lib { 
    # inherit (nixpkgs) lib; # FIXME does not work (needed?)
    # inherit pkgs;
    inherit inputs;
    inherit (inputs) home-manager;
    inherit stateVersion; };
  inherit (lib) mkOption types;
in
with lib; rec{

  # Helper function for generating host configs
  mkHost = 
    { 
      hostname, 
      username ? "nebilam", 
      desktop ? null, 
      platform ? "x86_64-linux" 
    }: 

    let
      isISO = builtins.substring 0 4 hostname == "iso-";
      isInstall = !isISO;
      isWorkstation = builtins.isString desktop; 
    in 
    # FIXME inputs.nixpkgs.lib.nixosSystem
    nixosSystem {
    specialArgs = {
      inherit 
        inputs 
        # home-manager
        outputs 
        myLib 
        desktop 
        hostname 
        platform 
        username 
        stateVersion
        isInstall
        isISO
        isWorkstation;
    };
    modules = [
      ../systems/${platform}
      inputs.home-manager.nixosModules.home-manager

      {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${username} = import ../modules/home/default.nix;
      }
      # ../modules/nixos
    ]; # NOTE  extra to generate iso: ++ (inputs.nixpkgs.lib.optionals (installer != null) [ installer ]);
  };

  forAllSystems = inputs.nixpkgs.lib.genAttrs [
    "aarch64-linux"
    "i686-linux"
    "x86_64-linux"
    "aarch64-darwin"
    "x86_64-darwin"
  ];

  # ========================== Modules =========================== #
  # NOTE mkOpt (not mkOption) is a custom lib function 
  mkOpt = type: default: description:
    # NOTE mkOption is a function from nixpkgs lib
    mkOption {inherit type default description;};

  # NOTE mkOpt' is mkOpt without a description (description = null)
  mkOpt' = type: default: mkOpt type default null;

  # NOTE mkBoolOpt is mkOpt with type bool
  mkBoolOpt = mkOpt types.bool;

  # NOTE mkBoolOpt' is mkBoolOpt without a description (description = null)
  mkBoolOpt' = mkOpt' types.bool;

  # NOTE mkEnableOpt is mkBoolOpt' with default valuu of false
  mkEnableOpt = mkBoolOpt' false;

  # LINK source: https://github.com/IogaMaster/dotfiles/blob/cb3172d9024a695dbdfd6a3c15b2d1d9ed88a9ef/lib/module/default.nix

}
