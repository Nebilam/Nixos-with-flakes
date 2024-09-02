
{
  options,
  config,
  lib,
  # myLib,
  ...
}:
with lib;
# with myLib; 

let
  cfg = config.apps.tools.direnv;
in {
  options.apps.tools.direnv = with types; {
    enable = mkBoolOpt false "Enable direnv";
  };

  config = mkIf cfg.enable {
    home.programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableFishIntegration = true;
      # FIXME nog iets toevoegen aan config file fish zodat fish integration werkt
    };

    # environment.sessionVariables.DIRENV_LOG_FORMAT = ""; # Blank so direnv will shut up

    # home.persist.directories = [
    #   ".local/share/direnv"
    # ];
  };
}
