deploy host="$(hostname)":
    @printf "rebulding {{ host }}\n"
    nixos-rebuild switch --flake .#{{ host }} --use-remote-sudo

deploy-impure host="$(hostname)":
    @printf "rebulding {{ host }}\n"
    nixos-rebuild switch --flake .#{{ host }} --use-remote-sudo --impure

debug host="$(hostname)":
    @printf "rebulding {{ host }} with debug\n"
    nixos-rebuild switch --flake .#{{ host }} --use-remote-sudo --show-trace --print-build-logs --verbose

generate-hardware-config host="$(hostname)":
    mkdir -p ./hosts/{{ host }}/
    nixos-generate-config --show-hardware-config > ./hosts/{{ host }}/hardware-configuration.nix

format:
    @printf "formatting files using alejandra"
    alejandra .

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
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --delete-older-than 30d

gc:
    @printf "collecting garbage...\n"
    sudo nix-collect-garbage --delete-older-than 30d

update-rebuild-clean host="$(hostname)":
    sudo just update
    sudo just deploy {{ host }}
    just gc
    just clean

list-all-packages:
    nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq
