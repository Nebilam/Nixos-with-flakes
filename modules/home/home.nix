{
  options,
  config,
  # lib,
  myLib,
  inputs,
  outputs,
  stateVersion,
  # username,
  ...
}:
# let
#   myLib = import ../../lib { inherit inputs stateVersion; };

# in
# with lib;
with myLib;rec
{
  imports = with inputs; [
    home-manager.nixosModules.home-manager
  ];
  # # imports = with inputs; [
  # #   home-manager.nixosModules.home-manager
  # #   # nix-colors.homeManagerModules.default
  # #   # prism.homeModules.prism
  # # ];

  # # NOTE 'with types' refers to lib and myLib 
  # options.home = with types; {
  #   file =
  #     # TODO bekijken waarom mkOption in plaats van mkOpt
  #     mkOpt attrs {}
  #     "A set of files to be managed by home-manager's <option>home.file</option>.";

  #   configFile =
  #     mkOpt attrs {}
  #     "A set of files to be managed by home-manager's <option>xdg.configFile</option>.";

  #   programs = mkOpt attrs {} "Programs to be managed by home-manager.";

  #   extraOptions = mkOpt attrs {} "Options to pass directly to home-manager.";

  #   persist = mkOpt attrs {} "Files and directories to persist in the home";
  # };

  config = {
    programs = {
      direnv = {
        enable = true;
      };
    };
  #   home-manager.users.nebilam = {
  #     home = {
  #       stateVersion = "23.05";
  #     };
  #   };
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