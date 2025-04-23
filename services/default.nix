{ pkgs, ... }:
{
  imports = [
    ./mihomo
    ./suspend-and-hibernate.nix
    ./acpid.nix
  ];
  services.postgresql = {
    enable = true;
    initialScript = pkgs.writeText "backend-initScript" ''
      create role ww with login password '1234' createdb;
      create database cesium;
      grant all privileges on database cesium to ww;
    '';
  };

}
