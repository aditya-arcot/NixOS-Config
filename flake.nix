{
    description = "NixOS system";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        grub2-themes.url = "github:vinceliuice/grub2-themes";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        vscode-server.url = "github:nix-community/nixos-vscode-server";
    };

    outputs =
        inputs@{
            nixpkgs,
            grub2-themes,
            home-manager,
            vscode-server,
            ...
        }:
        {
            nixosConfigurations = {
                nixos = nixpkgs.lib.nixosSystem {
                    system = "x86_64-linux";
                    specialArgs = { inherit inputs; };
                    modules = [
                        ./hardware-configuration.nix
                        ./configuration.nix
                        grub2-themes.nixosModules.default
                        home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.extraSpecialArgs = {
                                vscode-server = inputs.vscode-server;
                            };
                            home-manager.users.adityaarcot = import ./home.nix;
                        }
                    ];
                };
            };
        };
}
