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

        rust-analyzer
        # gui
        microsoft-edge
        siyuan
        sqlitebrowser
        showmethekey
        kooha
        telegram-desktop
        discord-ptb
        floorp
        blender
        drawio
      ]
      ++ (with pkgs.unstable; [
        quickemu
        navicat-premium
        cherry-studio
        qq
        onlyoffice-bin
      ])
      ++ (with gnomeExtensions; [
        hibernate-status-button
        custom-command-toggle
        # advanced-alttab-window-switcher
      ]);

    stateVersion = "24.11";
  };
}
