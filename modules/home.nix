# { options, pkgs, config, lib, inputs, ... }:
{ options, config, lib, inputs, outputs, username, ... }:

let 
  cfg = config.home;
in
{
  imports = with inputs; [
    home-manager.nixosModules.home-manager
  ];

  options.home = {
    extraOptions = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = ''
        Options to pass directly to home-manager
      '';
    };
  };

  config = {
    home.extraOptions.home.stateVersion = config.system.stateVersion;
    home-manager = {
      useUserPackages = true;

      # users.${config.user.name} = lib.mkAliasDefinitions options.home.extraOptions;
      users.${username} = lib.mkAliasDefinitions options.home.extraOptions;
    };
  };
}