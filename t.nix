#! /usr/bin/env -S nix-instantiate --eval
with import ./home/keybinding.nix;
let
  dconf = mkDconf [
    (mkKeybinding "1" "2" "3")
  ];
in
builtins.deepSeq dconf dconf
