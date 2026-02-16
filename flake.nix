{
    description = "NixOS system";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        grub2-themes.url = "github:vinceliuice/grub2-themes";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs =
        inputs@{
            nixpkgs,
            grub2-themes,
            home-manager,
            ...
        }:
        let
            makeHost =
                { hostName }:
                nixpkgs.lib.nixosSystem {
                    system = "x86_64-linux";
                    specialArgs = { inherit inputs; };
                    modules = [
                        (./hosts + "/${hostName}/configuration.nix")
                        grub2-themes.nixosModules.default
                        home-manager.nixosModules.home-manager
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.users.adityaarcot = import ./config/home.nix;
                        }
                    ];
                };
        in
        {
            nixosConfigurations = {
                desktop = makeHost { hostName = "desktop"; };
            };
        };
}
