{ pkgs, ... }:
{
  environment.gnome.excludePackages = with pkgs; [
    epiphany
  ];
  programs.dconf.enable = true;
  # services.udev.packages = with pkgs; [
  #   gnome-settings-daemon
  # ];
}
