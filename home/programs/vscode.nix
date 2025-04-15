{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions =
      with pkgs.open-vsx;
      [
        arrterian.nix-env-selector
        bbenoist.nix
        jnoortheen.nix-ide
        mkhl.direnv

        vscodevim.vim

        # rust
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        serayuzgur.crates

        # c
        dizy.lex-flex-yacc-bison

        # vue
        vue.volar
      ]
      ++ (with pkgs.vscode-marketplace; [
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit
        ms-vscode-remote.vscode-remote-extensionpack
        ms-python.python
        ms-vscode.cpptools
        aooiu.any-reader
        jcbuisson.vue
      ]);
    userSettings = {
      "window.titleBarStyle" = "custom";
      "vim.leader" = "<space>";
      "vim.handleKeys" = {
        "<C-p>" = false;
        "<C-d>" = true;
        "<C-s>" = false;
        "<C-z>" = false;
        "<C-r>" = false;
      };
      "vim.useSystemClipboard" = true;
      "editor.formatOnSave" = true;
      "editor.lineNumbers" = "relative";
      "editor.wordWrap" = "on";
      "nix.enableLanguageServer" = true;
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [
              "nixfmt"
            ];
          };
        };
      };
    };

    keybindings = [
      {
        key = "shift+u";
        command = "extension.vim_ctrl+r";
        when = "editorTextFocus && vim.active && vim.mode == 'Normal'";
      }
    ];
  };
}
