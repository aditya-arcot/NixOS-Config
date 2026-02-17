.PHONY: rebuild

rebuild-boot-desktop:
	sudo nixos-rebuild boot --flake .#desktop

rebuild-switch-desktop:
	sudo nixos-rebuild switch --flake .#desktop

rebuild-boot-mbp-t2:
	sudo nixos-rebuild boot --flake .#mbp-t2

rebuild-switch-mbp-t2:
	sudo nixos-rebuild switch --flake .#mbp-t2
