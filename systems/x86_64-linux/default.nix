{
  config,
  hostname,
  isInstall,
  isWorkstation,
  inputs,
  outputs,
  lib,
  myLib,
  modulesPath,
  pkgs,
  platform,
  username,
  ...
}:
{
  imports = [
    # inputs.catppuccin.nixosModules.catppuccin
    #inputs.determinate.nixosModules.default
    # inputs.nix-flatpak.nixosModules.nix-flatpak
    # inputs.nix-index-database.nixosModules.nix-index
    # inputs.sops-nix.nixosModules.sops
    (modulesPath + "/installer/scan/not-detected.nix")
    ./${hostname} # NOTE imports the default.nix file in that directory
    # ../../modules/home
    # ../../modules/apps/direnv
  ]; # ++ lib.optional isWorkstation ./_mixins/desktop;

  # NOTE I took this file from someone else and comment it out as much as possible to make teststing and finding bugs in the beginning simpler    
  # boot = {
  #   kernelModules = [ "vhost_vsock" ];
  #   kernelParams = [ "udev.log_priority=3" ];
  #   kernelPackages = pkgs.linuxPackages_latest;
  #   # Only enable the systemd-boot on installs, not live media (.ISO images)
  #   loader = lib.mkIf isInstall {
  #     efi.canTouchEfiVariables = true;
  #     systemd-boot.configurationLimit = 10;
  #     systemd-boot.consoleMode = "max";
  #     systemd-boot.enable = true;
  #     systemd-boot.memtest86.enable = true;
  #     timeout = 10;
  #   };
  # };

  # #determinate.nix.primaryUser.username = username;

  # # Only install the docs I use
  # documentation.enable = true;
  # documentation.nixos.enable = false;
  # documentation.man.enable = true;
  # documentation.info.enable = false;
  # documentation.doc.enable = false;

  # environment = {
  #   # Eject nano and perl from the system
  #   defaultPackages =
  #     with pkgs;
  #     lib.mkForce [
  #       coreutils-full
  #       micro
  #     ];

  #   systemPackages =
  #     with pkgs;
  #     [
  #       git
  #       nix-output-monitor
  #     ]
  #     ++ lib.optionals isInstall [
  #       inputs.nixos-needtoreboot.packages.${platform}.default
  #       nvd
  #       nvme-cli
  #       smartmontools
  #       sops
  #     ];

  #   variables = {
  #     EDITOR = "micro";
  #     SYSTEMD_EDITOR = "micro";
  #     VISUAL = "micro";
  #   };
  # };

  # nixpkgs = {
  #   # You can add overlays here
  #   overlays = [
  #     # Add overlays your own flake exports (from overlays and pkgs dir):
  #     outputs.overlays.additions
  #     outputs.overlays.modifications
  #     outputs.overlays.unstable-packages
  #     # Add overlays exported from other flakes:
  #   ];
  #   # Configure your nixpkgs instance
  #   config = {
  #     allowUnfree = true;
  #   };
  # };

  # nix = {
  #   optimise.automatic = true;
  #   settings = {
  #     auto-optimise-store = true;
  #     experimental-features = [
  #       "nix-command"
  #       "flakes"
  #     ];
  #     # warn-dirty = false;
  #   };
  # };

  # nixpkgs.hostPlatform = lib.mkDefault "${platform}";

  # programs = {
  #   command-not-found.enable = false;
  #   fish = {
  #     enable = true;
  #     shellAliases = {
  #       nano = "micro";
  #     };
  #   };
  #   nano.enable = lib.mkDefault false;
  #   nh = {
  #     clean = {
  #       enable = true;
  #       extraArgs = "--keep-since 15d --keep 10";
  #     };
  #     enable = true;
  #     flake = "/home/${username}/Zero/nix-config";
  #   };
  #   nix-index-database.comma.enable = isInstall;
  #   nix-ld = lib.mkIf isInstall {
  #     enable = true;
  #     libraries = with pkgs; [
  #       # Add any missing dynamic libraries for unpackaged
  #       # programs here, NOT in environment.systemPackages
  #     ];
  #   };
  # };

  # services = {
  #   fwupd.enable = isInstall;
  #   hardware.bolt.enable = true;
  #   smartd.enable = isInstall;
  # };

  # sops = lib.mkIf (isInstall && username == "martin") {
  #   age = {
  #     keyFile = "/home/${username}/.config/sops/age/keys.txt";
  #     generateKey = false;
  #   };
  #   defaultSopsFile = ../secrets/secrets.yaml;
  #   # sops-nix options: https://dl.thalheim.io/
  #   secrets = {
  #     test-key = { };
  #     homepage-env = { };
  #   };
  # };

  # systemd.tmpfiles.rules = [ "d /nix/var/nix/profiles/per-user/${username} 0755 ${username} root" ];

  # system = {
  #   nixos.label = lib.mkIf isInstall "-";
  #   inherit stateVersion;
  # };
}