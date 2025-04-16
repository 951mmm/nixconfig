with import ./lib.nix;
(mkDconf [
  (mkKeybinding "terminal" "kgx" "<Control><Alt>t")
  (mkKeybinding "flameshot" ./flameshot-gui.sh "Print")
  (mkKeybinding "power-unlock" ./power-unlock.sh "Launch1")
])
// {
  "org/gnome/shell/keybindings" = {
    show-screenshot-ui = [ ];
  };
}
