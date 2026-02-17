{
    config,
    lib,
    pkgs,
    ...
}:

{
    imports = [
        ./hardware-configuration.nix
    ];

    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = false;

    networking.hostName = "mbp-t2";
    networking.networkmanager.enable = true;

    time.timeZone = "America/Chicago";

    services.xserver.enable = true;
    services.xserver.xkb.layout = "us";
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.openssh.enable = true;

    programs.firefox.enable = true;
    programs.dconf.enable = true;
    programs.nix-ld.enable = true;
    programs.zsh.enable = true;

    environment.systemPackages = with pkgs; [
        curl
        ethtool
        grub2
        nixfmt
        vim
        wget
    ];
    # disable suspend
    environment.etc."xdg/powermanagementprofilesrc".text = ''
        [AC][SuspendSession]
        idleTime=0

        [Battery][SuspendSession]
        idleTime=0
    '';

    users.defaultUserShell = pkgs.zsh;
    users.users.adityaarcot = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
    };

    hardware.firmware = [
        (pkgs.stdenvNoCC.mkDerivation {
            name = "brcm-firmware";
            src = ./firmware/brcm;

            installPhase = ''
                mkdir -p $out/lib/firmware/brcm
                cp $src/* $out/lib/firmware/brcm
            '';
        })
    ];

    # do not change - https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
    system.stateVersion = "25.11";
}
