let
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

in
{
  # attr字段顺序问题
  ## attr字段顺序必须和文档严格一致
  # mkKeybinding -> str -> path | str -> str
  mkKeybinding =
    with builtins;
    name: command-outer: binding:
    let
      command = if typeOf command-outer == "path" then toString command-outer else command-outer;
    in
    {
      inherit binding command name;
    };
  mkDconf =
    with builtins;
    keybindings:
    let
      my-keybindings = mkKeybindings keybindings;
      dconf-custom-keybindings = map ({ name, ... }: "/${name}/") my-keybindings;
      dconf-media-keys = {
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = dconf-custom-keybindings;
        };
      };
      dconf-keybindings = listToAttrs my-keybindings;
    in
    dconf-media-keys // dconf-keybindings;
}
