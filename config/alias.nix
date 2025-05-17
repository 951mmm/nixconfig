let
  nix-config-dir = "/home/nixconfig";
  # nix-config-bak = "/home/nixconfig.bak";
  readlink = path: "$(readlink -f ${path})";
  config-dir = readlink nix-config-dir;
  # config-bak = readlink nix-config-bak;
  # max-generation = "nixos-rebuild list-generations | awk 'NR == 2{print $1}' | tr -d '\n\b'";
  # commit-msg = "generation: $(${max-generation})";
  nix-rebuild = arg: "sudo nixos-rebuild ${arg} --flake ${config-dir}";
  aliases = {
    # nix
    nrb = nix-rebuild "boot";
    nrs = nix-rebuild "switch";
    nrt = nix-rebuild "test";
    nrd = nix-rebuild "dry-activate";
    nrr = nix-rebuild "switch --rollback";
    encfg = "vi ${nix-config-dir}";

    # git
    ga = "git add";
    gc = "git commit";
    gs = "git status";
    gl = "git log";
    gsl = "git shortlog";

  };
  browser = url: "microsoft-edge ${builtins.toString url}";
  win10-conf-path = "/home/ww/公共/vm/windows-10.conf";

in
{
  environment.shellAliases = aliases;
  home-manager.users.ww.programs.bash.shellAliases = aliases // {
    # vscode
    code = "codium";
    encfg = "codium ${config-dir}";

    # web app?
    mui = browser "https://d.metacubex.one/";
    noogle = browser "https://noogle.dev/";
    nsh = browser "https://nixos.org/nixos/packages.html";

    # qemu
    qe-win10 = "${win10-conf-path}";
    qe-win10-off = "pkill -f \"qemu.* -name windows-10\"";

    # qq
    qq-off = "pkill -f QQ";
  };
}
