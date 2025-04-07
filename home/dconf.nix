{
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "hibernate-status@dromi"
        # "advanced-alt-tab@G-dH.github.com"
        "custom-command-toggle@storageb.github.com"

      ];
      disabled-extensions = [ ];
    };

    "org/gnome/Console" = {
      custom-font = "Monospace 12";
      use-system-font = false;
    };

  };
}
