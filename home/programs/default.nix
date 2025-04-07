{ config, ... }:
{
  imports = [
    ./vscode.nix
  ];

  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      bashrcExtra = ''
        export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
      '';
    };

    git = {
      enable = true;
      userName = "951mmm";
      userEmail = "w1w5w9m5m1m@gmail.com";
      extraConfig = {
        core = {
          editor = "vim";
        };
      };
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    zed-editor = {
      enable = true;
    };

    home-manager.enable = true;
  };
}
