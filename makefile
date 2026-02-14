.PHONY: rebuild

rebuild-boot:
	sudo nixos-rebuild boot --flake .#nixos

rebuild-switch:
	sudo nixos-rebuild switch --flake .#nixos
