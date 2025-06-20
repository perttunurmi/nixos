deploy-T480s:
    nixos-rebuild switch --flake .#T480s --use-remote-sudo

debug-T480s:
    nixos-rebuild switch --flake .#T480s --use-remote-sudo --show-trace --verbose

deploy-VMware:
    nixos-rebuild switch --flake .#VMware --use-remote-sudo

debug-VMware:
    nixos-rebuild switch --flake .#VMware --use-remote-sudo --show-trace --verbose

deploy-WSL:
    nixos-rebuild switch --flake .#WSL --use-remote-sudo --impure

debug-WSL:
    nixos-rebuild switch --flake .#WSL --impure --use-remote-sudo --show-trace --verbose

update:
    nix flake update

update_:
    nix flake update $(i)

history:
    nix profile history --profile /nix/var/nix/profiles/system

repl:
    nix repl -f flake:nixpkgs

clean:
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
    sudo nix-collect-garbage --delete-old
