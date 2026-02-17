# NixOS-Config

Personal NixOS configuration using flakes and Home Manager. This repo defines two hosts and a shared Home Manager setup with curated dotfiles.

## Structure

- `flake.nix`: Flake entrypoint, inputs, and `nixosConfigurations` for each host.
- `hosts/`
	- `desktop/`: Desktop host with GRUB and custom boot entries.
	- `mbp-t2/`: MacBook Pro T2 host using `nixos-hardware` and bundled Broadcom firmware.
- `config/`: Home Manager configuration and dotfiles.
	- `home.nix`: Home Manager module and program setup.
	- `.zshrc`, `.p10k.zsh`, `eza.theme.yml`, `fastfetch.config.jsonc`, `gitconfig`: Managed user configs.
- `makefile`: Convenience targets for rebuilding each host.
- `template.nix`: Zsh/oh-my-zsh custom theme and plugin build.

## Usage

Rebuild a specific host:

```sh
make rebuild-boot-desktop
make rebuild-switch-desktop

make rebuild-boot-mbp-t2
make rebuild-switch-mbp-t2
```

You can also run Nix directly:

```sh
sudo nixos-rebuild switch --flake .#desktop
sudo nixos-rebuild switch --flake .#mbp-t2
```
