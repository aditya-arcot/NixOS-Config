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
    # required for wifi to work on boot
    networking.wireless.enable = true;
    networking.wireless.interfaces = [ "wlp229s0" ];
    networking.wireless.extraConfigFiles = [ "/etc/wpa_supplicant/wpa_supplicant.conf" ];
    # mutually exclusive with wpa_supplicant
    networking.networkmanager.enable = false;

    time.timeZone = "America/Chicago";

    services.xserver.enable = true;
    services.xserver.xkb.layout = "us";
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.openssh.enable = true;
    services.logind.settings.Login = {
        HandleLidSwitch = "ignore";
        HandleLidSwitchDocked = "ignore";
        HandleHibernateKey = "ignore";
    };

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

    systemd.sleep.extraConfig = ''
        AllowSuspend=no
        AllowHibernation=no
        AllowHybridSleep=no
        AllowSuspendThenHibernate=no
    '';

    # do not change - https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
    system.stateVersion = "25.11";
}
