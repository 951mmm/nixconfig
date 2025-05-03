{ config, pkgs, ... }:
let
  huawei-wmi = config.boot.kernelPackages.callPackage ./spec/huawei-wmi.nix { };
  huawei-wmi-kbd-udev = builtins.readFile ./spec/99-Huawei.hwdb;

  zh-fonts = pkgs.callPackage ./zh-fonts.nix { inherit pkgs; };
in
{
  imports = [
    ./docker.nix
    ./gnome.nix
  ];
  # kmod spec
  boot.extraModulePackages = [
    huawei-wmi
  ];

  # hwdb
  services.udev.extraHwdb = ''
    ${huawei-wmi-kbd-udev}
  '';
  # zram
  zramSwap.enable = true;

  # nixgc
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };

  # 中文字体
  fonts = {
    packages = with pkgs; [
      fira-code-nerdfont
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      zh-fonts
    ];
    fontconfig = {
      antialias = true;
      hinting.enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "FiraCode Nerd Font" ];
        sansSerif = [ "Noto Sans CJK SC" ];
        serif = [ "Noto Serif CJK SC" ];
      };
    };
  };
  # 输入法
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      libpinyin
    ];
  };

  # flake
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # packages
  environment.systemPackages = with pkgs; [
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    # mihomo
    wget
    acpid
    wl-clipboard

    # gui
    flameshot
    waydroid
  ];

  # waydroid
  virtualisation.waydroid.enable = true;

  # firewall
  # networking.firewall.enable = true;
}
