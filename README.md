# NixOS-Config

Personal NixOS configuration using flakes and Home Manager.

## Structure

- `flake.nix`: Flake entrypoint and system definitions.
- `configuration.nix`: System configuration.
- `hardware-configuration.nix`: Hardware-specific settings.
- `home.nix`: Home Manager user configuration.

## Usage

```sh
make rebuild-boot
make rebuild-switch
```
