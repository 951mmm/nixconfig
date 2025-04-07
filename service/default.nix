{ ... }:
{
  imports = [
    ./hello.nix
  ];

  service.hello = {
    enable = true;
    greeter = "ww";
  };
}
