{ config, pkgs, ... }:
let
  huawei-wmi = config.boot.kernelPackages.callPackage ./spec/huawei-wmi.nix { };
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
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
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
    acpica-tools
    flameshot
  ];
}
