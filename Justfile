deploy host="$(hostname)":
    @printf "rebulding {{ host }}\n"
    nixos-rebuild switch --flake .#{{ host }} --use-remote-sudo --upgrade

deploy-impure host="$(hostname)":
    @printf "rebulding {{ host }}\n"
    nixos-rebuild switch --flake .#{{ host }} --use-remote-sudo --upgrade --impure

debug host="$(hostname)":
    @printf "rebulding {{ host }} with debug\n"
    nixos-rebuild switch --flake .#{{ host }} --use-remote-sudo --show-trace --verbose

generate-hardware-config host="$(hostname)":
    mkdir -p ./hosts/{{ host }}/
    nixos-generate-config --show-hardware-config > ./hosts/{{ host }}/hardware-configuration.nix

format:
    nix fmt

update:
    @printf "updating channels...\n"
    sudo nix-channel --update
    sudo nix-channel --list
    nix flake update

history:
    nix profile history --profile /nix/var/nix/profiles/system

repl:
    nix repl -f flake:nixpkgs

clean:
    @printf "deleting history older than 7 days...\n"
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
    @printf "collecting garbage...\n"
    sudo nix-collect-garbage --delete-old

update-rebuild-clean host="$(hostname)":
    sudo just update
    sudo just deploy {{ host }}
    just gc
    just clean
