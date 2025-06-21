deploy:
    @printf "rebulding $(hostname)\n"
    nixos-rebuild switch --flake .#$(hostname) --use-remote-sudo --upgrade

deploy-impure:
    @printf "rebulding $(hostname)\n"
    nixos-rebuild switch --flake .#$(hostname) --use-remote-sudo --upgrade --impure

deploy-T480s:
    @printf "rebulding T480s\n"
    nixos-rebuild switch --flake .#T480s --use-remote-sudo --upgrade

debug-T480s:
    @printf "rebulding T480s with debug\n"
    nixos-rebuild switch --flake .#T480s --use-remote-sudo --show-trace --verbose

deploy-VMware:
    @printf "rebulding VMware\n"
    nixos-rebuild switch --flake .#VMware --use-remote-sudo --upgrade

debug-VMware:
    @printf "rebulding VMware with debug\n"
    nixos-rebuild switch --flake .#VMware --use-remote-sudo --show-trace --verbose

deploy-WSL:
    @printf "rebulding WSL\n"
    nixos-rebuild switch --flake .#WSL --use-remote-sudo --impure --upgrade

debug-WSL:
    @printf "rebulding WSL with debug\n"
    nixos-rebuild switch --flake .#WSL --impure --use-remote-sudo --show-trace --verbose

generate-hardware-config host:
    nixos-generate-config --show-hardware-config > hardware-configuration.nix

update:
    sudo nix-channel --update
    sudo nix-channel --list
    nix flake update

history:
    nix profile history --profile /nix/var/nix/profiles/system

repl:
    nix repl -f flake:nixpkgs

clean:
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
    sudo nix-collect-garbage --delete-old
