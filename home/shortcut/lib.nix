let

  # attr字段顺序问题
  ## attr字段顺序必须和文档严格一致
  mkKeybinding = name: command: binding: {
    inherit binding command name;
  };

  custom-keybinding-key =
    i: "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${toString i}";
  mkKeybindings =
    keybindings:
    let
      aux =
        acc: i:
        if i == builtins.length keybindings then
          acc
        else
          aux (
            acc
            ++ [
              {
                name = custom-keybinding-key i;
                value = builtins.elemAt keybindings i;
              }
            ]
          ) (i + 1);
    in
    aux [ ] 0;

  mkDconf =
    keybindings:
    let
      my-keybindings = mkKeybindings keybindings;
      dconf-custom-keybindings = builtins.map ({ name, ... }: "/${name}/") my-keybindings;
      dconf-media-keys = {
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = dconf-custom-keybindings;
        };
      };
      dconf-keybindings = builtins.listToAttrs my-keybindings;
    in
    dconf-media-keys // dconf-keybindings;
in
{
  inherit mkDconf mkKeybinding;
  # 暂时使用绝对路径
  shortcut-script-dir = "/home/ww/文档/nixconfig.d/home/shortcut";
}
