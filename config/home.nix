{
    config,
    pkgs,
    ...
}:
let
    autoupdate = pkgs.fetchFromGitHub {
        owner = "tamcore";
        repo = "autoupdate-oh-my-zsh-plugins";
        rev = "master";
        sha256 = "sha256-gsRLMOGhjiirfrQ83UacDKkcMxkVf8ogNQeqfuuOTVg=";
    };
    # zsh-fast-syntax-highlighting from nixpkgs does not work
    fast-syntax-highlighting = pkgs.fetchFromGitHub {
        owner = "zdharma-continuum";
        repo = "fast-syntax-highlighting";
        rev = "v1.56";
        sha256 = "sha256-caVMOdDJbAwo8dvKNgwwidmxOVst/YDda7lNx2GvOjY=";
    };
    zsh-customs = pkgs.stdenv.mkDerivation {
        name = "zsh-customs";
        phases = [ "buildPhase" ];
        buildPhase = ''
            mkdir -p $out/themes/powerlevel10k
            cp -r ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/* \
                $out/themes/powerlevel10k/

            mkdir -p $out/plugins
            cp -r ${fast-syntax-highlighting} $out/plugins/fast-syntax-highlighting
            cp -r ${autoupdate} $out/plugins/autoupdate
        '';
    };
in
{
    imports = [
        "${
            fetchTarball {
                url = "https://github.com/msteen/nixos-vscode-server/tarball/master";
                sha256 = "sha256:0xjal4zcbmdjdaspfkjbpx1680q7390wfzmj7iad04kp3pc9syf8";
            }
        }/modules/vscode-server/home.nix"
    ];

    home.username = "adityaarcot";
    home.homeDirectory = "/home/adityaarcot";
    home.stateVersion = "25.11";
    home.packages = with pkgs; [
        eza
        fastfetch
        gnumake
        meslo-lgs-nf
    ];
    home.file.".p10k.zsh".source = ./.p10k.zsh;
    home.file.".config/zsh/.zshrc".source = ./.zshrc;
    home.file.".config/eza/theme.yml".source = ./eza.theme.yml;
    home.file.".config/fastfetch/config.jsonc".source = ./fastfetch.config.jsonc;
    home.file.".gitconfig".source = ./gitconfig;

    programs.home-manager.enable = true;
    programs.git.enable = true;
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
    programs.zoxide.enable = true;
    programs.zsh = {
        enable = true;
        initContent = ''
            source "$HOME/.config/zsh/.zshrc"
        '';
        oh-my-zsh = {
            enable = true;
            theme = "powerlevel10k/powerlevel10k";
            plugins = [
                "autoupdate"
                "colored-man-pages"
                "fast-syntax-highlighting"
                "git"
            ];
            custom = "${zsh-customs}";
        };
        plugins = [
            {
                name = "powerlevel10k";
                src = pkgs.zsh-powerlevel10k;
                file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            }
            {
                name = pkgs.zsh-autosuggestions.pname;
                src = pkgs.zsh-autosuggestions.src;
            }
        ];
    };

    services.ssh-agent.enable = true;
    services.vscode-server.enable = true;
}
