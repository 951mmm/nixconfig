{ pkgs, ... }:

{
  imports = [
    ./dconf.nix
    ./programs
  ];
  home = {
    username = "ww";
    homeDirectory = "/home/ww";
    packages =
      with pkgs;
      [
        # cli
        lsof
        libnotify

        # dev cli
        gnumake42

        dconf2nix
        nil
        nixfmt-rfc-style
        jmeter

        rust-analyzer
        # gui
        microsoft-edge
        wpsoffice-cn
        siyuan
        sqlitebrowser
        showmethekey
        kooha
        telegram-desktop
        discord-ptb
        floorp
        blender
        drawio
        remmina
        wechat-uos
      ]
      ++ (with pkgs.unstable; [
        quickemu
        navicat-premium
        cherry-studio
        qq
      ])
      ++ (with gnomeExtensions; [
        hibernate-status-button
        custom-command-toggle
        # advanced-alttab-window-switcher
      ]);

    stateVersion = "24.11";
  };
}
