{
  options,
  config,
  lib,
  myLib,
  inputs,
  outputs,
  stateVersion,
  username,
  ...
}:
# let
#   myLib = import ../../lib { inherit inputs stateVersion; };

# in
# with lib;
# with myLib;
rec
{
  imports = with inputs; [
    home-manager.nixosModules.home-manager
  ];

  # NOTE 'with types' refers to lib and myLib 
  # options.home = with types; {
  options.home =  {
    file =
      # TODO bekijken waarom mkOption in plaats van mkOpt
      myLib.mkOpt lib.types.attrs {}
      "A set of files to be managed by home-manager's <option>home.file</option>.";

    configFile =
      myLib.mkOpt lib.types.attrs {}
      "A set of files to be managed by home-manager's <option>xdg.configFile</option>.";

    programs = myLib.mkOpt lib.types.attrs {} "Programs to be managed by home-manager.";

    extraOptions = myLib.mkOpt lib.types.attrs {} "Options to pass directly to home-manager.";

    persist = myLib.mkOpt lib.types.attrs {} "Files and directories to persist in the home";
  };

  config = {
    programs = {
      direnv = {
        enable = true;
      };
    };
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      # users.${username} = {
      #   # imports = [];
      #   home = {
      #     stateVersion = stateVersion; 
      #     # stateVersion = config.system.stateVersion or stateVersion;
      #     # extraOptions = config.system.extraOptions
      #     # extraOptions = {
      #     #   xdg.enable = true;
      #     # };
      #   };
      # };
      user.${username} = lib.mkAliasDefinitions options.home.extraOptions;
    };
    # home.extraOptions = {
      # home.stateVersion = config.system.stateVersion or "23.05";
      # home.file = mkAliasDefinitions options.home.file;
      # xdg.enable = true;
      # xdg.configFile = mkAliasDefinitions options.home.configFile;
      # programs = mkAliasDefinitions options.home.programs;
  };


  #   home-manager = {
  #     useGlobalPkgs = true;

  #     # FIXME this does not work yet because modules/nixos/user is not yet implemented (see Iogamaster)
  #     # users.${config.user.name} =
  #     #   mkAliasDefinitions options.home.extraOptions;
  #     # FIXME this doesn't work!!!
  #     users.${username} =
  #       mkAliasDefinitions options.home.extraOptions;
  #   };

  #   # environment.persistence."/persist".users.${config.user.name} = mkIf options.impermanence.enable.value (mkAliasDefinitions options.home.persist);
  # };
}