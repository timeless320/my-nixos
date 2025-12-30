# NixOS Configuration

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # timezone
  time.timeZone = "America/New_York";

  # internationalisation
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # user
  users.users.shinobi = {
    isNormalUser = true;
    description = "shinobi";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "hum";
    packages = with pkgs; [
     kdePackages.kate
    ];
  };

  # graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFrewall = true;
  };

  # hyprland
  programs.hyprland.enable = true;

  # unfree
  nixpkgs.config.allowUnfree = true;
  
  # firefox
  programs.firefox.enable = true;

  # system packages
  environment.systemPackages = with pkgs; [
     kitty
     hyprpolkitagent
  ];

  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # git
  programs.git.enable = true;

  system.stateVersion = "25.11"; # Did you read the comment?
}
