{
  pkgs,
  lib,
  config,
  ...
}:
let
  mkConfig =
    host: port:
    let
      http-proxy = "http://${host}:${builtins.toString port}";
      no-proxy = "127.0.0.1,localhost,internal.domain";
      default-proxy = {
        host = "http://${host}";
        inherit port;
      };
    in
    {

      # system proxy
      # Configure network proxy if necessary
      networking.proxy.default = http-proxy;
      networking.proxy.noProxy = no-proxy;

      # gnome proxy
      home-manager.users.ww.dconf.settings = {
        "system/proxy/mode" = {
          mode = "manual";
          ignore-hosts = [
            "localhost"
            "127.0.0.0/8"
            "::1"
          ];
        };
        "system/proxy/http" = default-proxy;
        "system/proxy/https" = default-proxy;
      };

      # home shell proxy
      home-manager.users.ww.programs.bash.bashrcExtra = ''
        export http_proxy="${http-proxy}"
        export https_proxy="${http-proxy}"
      '';
    };
in
{
  options.my-config.proxy = {
    enable = lib.mkEnableOption "proxy for system user and gnome";
    username = lib.mkOption {
      type = lib.types.str;
      default = "ww";
      description = "用户空间代理";
    };
    host = lib.mkOption {
      type = lib.types.str;
      default = "127.0.0.1";
      description = "代理http地址";
    };
    port = lib.mkOption {
      type = lib.types.port;
      default = 7890;
      description = "代理端口";
    };
  };

  config =
    let
      cfg = config.my-config.proxy;
    in
    lib.mkIf cfg.enable (mkConfig cfg.host cfg.port);

}
