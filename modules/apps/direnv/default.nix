
{
  # options,
  config,
  lib,
  ...
}:

let
  cfg = config.apps.direnv;
in 
{
  options.apps.direnv = {
    enable = lib.mkEnableOption "Enable direnv and nix-direnv";
  };

  config = lib.mkIf cfg.enable {
    home.extraOptions.programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableFishIntegration = true;
      # FIXME nog iets toevoegen aan config file fish zodat fish integration werkt
    };

    # environment.sessionVariables.DIRENV_LOG_FORMAT = ""; # Blank so direnv will shut up

  };
}
