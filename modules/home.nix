{ options, pkgs, config, lib, inputs, ... }:

let cfg = config.home;
in
{
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

      users.${config.user.name} = lib.mkAliasDefinitions options.home.extraOptions;
    };
  };
}