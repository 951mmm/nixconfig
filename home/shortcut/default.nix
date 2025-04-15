with import ./lib.nix;
(mkDconf [
  (mkKeybinding "terminal" "kgx" "<Control><Alt>t")
  (mkKeybinding "flameshot" "${shortcut-script-dir}/flameshot-gui.sh" "Print")
])
// {
  "org/gnome/shell/keybindings" = {
    show-screenshot-ui = [ ];
  };
}
