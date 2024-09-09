{ inputs, ... }:

let

  helpers = import ./helpers.nix { inherit inputs ; };
  
in

{
  inherit (helpers) mkHost forAllSystems mkOpt mkOpt' mkBoolOpt mkBoolOpt' mkEnableOpt;
}
