{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  users.users.ww.extraGroups = [ "docker" ];
  users.extraGroups.docker.members = [ "ww" ];

  environment.systemPackages = [ pkgs.docker ];
}
