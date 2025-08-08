default:
    @just --list

deploy host="$(hostname)":
    git add .
    @printf "rebulding {{ host }}\n"
    nixos-rebuild switch --flake .#{{ host }} --use-remote-sudo

test host="$(hostname)":
    git add .
    @printf "rebulding {{ host }}\n"
    nixos-rebuild test --flake .#{{ host }} --use-remote-sudo --impure

deploy-impure host="$(hostname)":
    git add .
    @printf "rebulding {{ host }}\n"
    nixos-rebuild switch --flake .#{{ host }} --use-remote-sudo  --impure

debug host="$(hostname)":
    git add .
    @printf "rebulding {{ host }} with debug\n"
    nixos-rebuild switch --flake .#{{ host }} --use-remote-sudo --show-trace --print-build-logs --verbose

generate-hardware-config host="$(hostname)":
    nixos-generate-config --show-hardware-config > ./hosts/{{ host }}/hardware-configuration.nix

[group('utils')]
format:
    @printf "formatting files using alejandra"
    alejandra .

update-all:
    sudo nix-channel --update
    sudo nix-channel --list
    nix flake update

[group('utils')]
history:
    nix profile history --profile /nix/var/nix/profiles/system

[group('utils')]
repl:
    nix repl -f flake:nixpkgs

[group('utils')]
clean old="30":
    @printf "deleting history older than {{ old }} days...\n"
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than {{old}}d

[group('utils')]
gc old="30":
    @printf "collecting garbage...\n"
    sudo nix-collect-garbage --delete-older-than {{ old }}d

update-rebuild-clean host="$(hostname)":
    sudo just update-all
    sudo just deploy {{ host }}
    just gc
    just clean

[group('utils')]
list-all-packages:
    nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq

commit:
    just format
    git add .
    git commit

[group('utils')]
check url=".":
    nix flake check {{ url }}
