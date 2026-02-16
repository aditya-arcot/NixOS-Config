.PHONY: rebuild

rebuild-boot:
	sudo nixos-rebuild boot --flake .#deskop

rebuild-switch:
	sudo nixos-rebuild switch --flake .#desktop
