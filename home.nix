{ config, pkgs, ... }:

{
  home.username = "nlazic";
  home.homeDirectory = "/home/nlazic";
  home.stateVersion = "25.05";

  programs = {
    git.enable = true;
    tmux.enable = true;
    neovim = {
        enable = true;
        defaultEditor = true;  # postavlja kao $EDITOR
        viAlias = true;        # pravi 'vi' alias
        #vimAlias = true;       # pravi 'vim' alias
    };
  };

  home.packages = with pkgs; [
    dex
    xss-lock
    networkmanagerapplet
    pavucontrol
    
    feh
    picom
    rofi
    nitrogen
  ];

  #i3
  home.file.".config/i3" = {
    source = ./user/wm/i3;
    recursive = true;
  };
}
