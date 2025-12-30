# nixos configuration
{ config, lib, pkgs, ... }:

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

  # hostname
  networking.hostName = "nixos";

  # networkmanager
  networking.networkmanager.enable = true;

  # time zone
  time.timeZone = "America/New_York";
  
  # graphics
  hardware.graphics = {
    enable = true;
  };
  
  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];
  
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
        offload.enable = true;
        amdgpuBusId = "PCI:6:0:0";
        nvidiaBusId = "PCI:1:0:0";
    };
  };
  
  # hyprland
  services.xserver.enable = true;
  programs.hyprland = {
    enable = true;
  };

  # printing
  services.printing.enable = true;

  # audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # touchpad support
  services.libinput.enable = true;

  # user account
  users.users.shinobi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "libvirtd" ];
    packages = with pkgs; [
       git
       tree
       xwayland-satellite
       kdePackages.dolphin
       kdePackages.kate
    ];
  };

  # firefox
  programs.firefox.enable = true;
  
  # steam
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true;
  dedicatedServer.openFirewall = true;
  };
  
  # nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # unfree
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
    "nvidia-x11"
    "nvidia-settings"
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

  # system packages
  environment.systemPackages =  with pkgs; [
    dnsmasq
  ];

  # virtualization
  virtualisation.libvirtd = {
  enable = true;
  qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };
  programs.virt-manager.enable = true;
  
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}

