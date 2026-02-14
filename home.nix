{ config, pkgs, vscode-server, ... }:

{
  imports = [
    "${vscode-server}/modules/vscode-server/home.nix"
  ];

  home.username = "adityaarcot";
  home.homeDirectory = "/home/adityaarcot";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    nixfmt
  ];

  programs.git = {
    enable = true;
    settings.user.name = "aditya-arcot";
    settings.user.email = "dev@aarcot.com";
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  services.ssh-agent.enable = true;

  services.vscode-server.enable = true;

  programs.zsh.enable = true;
}
