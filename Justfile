default:
    @just --list

[group('build')]
rebuild host="$(hostname)":
    @printf "rebulding {{ host }}\n"
    nixos-rebuild switch --flake .#{{ host }} --sudo

[group('build')]
test host="$(hostname)":
    @printf "rebulding {{ host }}\n"
    nixos-rebuild test --flake .#{{ host }} --sudo --impure

[group('build')]
debug host="$(hostname)":
    @printf "rebulding {{ host }} with debug\n"
    nixos-rebuild test --flake .#{{ host }} --use-remote-sudo --show-trace --print-build-logs --verbose

[group('build')]
rebuild-impure host="$(hostname)":
    @printf "rebulding {{ host }}\n"
    nixos-rebuild switch --flake .#{{ host }} --sudo  --impure

[group('rebuild')]
update-rebuild host="$(hostname)":
    sudo just update-all
    sudo just deploy {{ host }}

[group('setup')]
generate-hardware-config host="$(hostname)":
    nixos-generate-config --show-hardware-config > ./hosts/{{ host }}/hardware-configuration.nix

[group('utils')]
format:
    @printf "formatting files using alejandra"
    alejandra .

[group('utils')]
history:
    nix profile history --profile /nix/var/nix/profiles/system

[group('utils')]
repl:
    nix repl -f flake:nixpkgs

[group('cleanup')]
clean old="30":
    @printf "deleting history older than {{ old }} days...\n"
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than {{old}}d

[group('cleanup')]
gc old="30":
    @printf "collecting garbage...\n"
    sudo nix-collect-garbage --delete-older-than {{ old }}d

[group('update')]
update-all:
    sudo nix-channel --update
    sudo nix-channel --list
    nix flake update

[group('utils')]
list-all-packages:
    nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq

[group('utils')]
check url=".":
    nix flake check {{ url }}
