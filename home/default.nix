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
        pkgs.unstable.quickemu
        libnotify
        wl-clipboard

        # dev cli
        gnumake42

        dconf2nix
        nil
        nixfmt-rfc-style

        rust-analyzer
        # gui
        microsoft-edge
        qq
        wpsoffice-cn
        siyuan
        sqlitebrowser
      ]
      ++ (with gnomeExtensions; [
        hibernate-status-button
        custom-command-toggle
        # advanced-alttab-window-switcher
      ]);

    stateVersion = "24.11";
  };
}
