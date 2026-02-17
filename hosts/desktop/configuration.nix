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

    boot.loader.systemd-boot.enable = false;
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.useOSProber = false;
    boot.loader.grub.extraEntries = ''
        menuentry "Windows Boot Manager" {
          insmod part_gpt
          insmod fat
          search --no-floppy --fs-uuid --set=root 8DFB-3653
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }

        menuentry "Arch Linux" {
          insmod part_gpt
          insmod ext2
          search --no-floppy --fs-uuid --set=root b7c1f43e-76ea-4610-8af4-61d54f4a59b3
          linux /boot/vmlinuz-linux root=UUID=b7c1f43e-76ea-4610-8af4-61d54f4a59b3 rw loglevel=3 quiet nvidia-drm.modeset=1 nvidia-drm.fbdev=1
          initrd /boot/amd-ucode.img /boot/initramfs-linux.img
        }
    '';
    boot.loader.grub2-theme = {
        theme = "stylish";
        footer = true;
    };
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "desktop";
    networking.networkmanager.enable = true;
    networking.interfaces.eno1.wakeOnLan = {
        enable = true;
        policy = [ "magic" ];
    };

    time.timeZone = "America/Chicago";

    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm.enable = true;
    services.openssh.enable = true;
    services.xserver.enable = true;
    services.xserver.xkb.layout = "us";

    programs.dconf.enable = true;
    programs.firefox.enable = true;
    programs.nix-ld.enable = true;
    programs.zsh.enable = true;

    # disable suspend
    environment.etc."xdg/powermanagementprofilesrc".text = ''
        [AC][SuspendSession]
        idleTime=0
    '';
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

    # do not change - https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
    system.stateVersion = "25.11";
}
