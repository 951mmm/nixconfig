{ ... }:
{
  imports = [
    ./proxy.nix
    ./alias.nix
  ];

  my-config.proxy.enable = true;
}
