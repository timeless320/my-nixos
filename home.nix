{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "shinobi";
  home.homeDirectory = "/home/shinobi";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    xdg-desktop-portal-hyprland
    fuzzel
    wl-clipboard
    swayidle
    swaybg
    wlr-randr
    gtklock
    hyprpicker
    swayidle
    vesktop
    noto-fonts
    nerd-fonts.noto
    nerd-fonts.fira-code
    protonup-qt
  ];

  xdg.enable = true;
  programs.waybar.enable = true;
  programs.wlogout.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/hypr/hyprland.conf".source = ./dotfiles/hyprland/hyprland.conf;
    ".config/waybar/config.jsonc".source = ./dotfiles/waybar/config.jsonc;
    ".config/waybar/style.css".source = ./dotfiles/waybar/style.css;
    ".config/wlogout/layout".source = ./dotfiles/wlogout/layout;
    ".config/wlogout/style.css".source = ./dotfiles/wlogout/style.css;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/shinobi/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
