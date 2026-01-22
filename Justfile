default:
    @just --list

[group('build')]
rebuild host="$(hostname)":
    @printf "{{ BOLD + GREEN }}rebulding {{ host }}:\n\n{{ NORMAL }}"
    nixos-rebuild switch --flake .#{{ host }} --sudo

[group('build')]
test host="$(hostname)":
    @printf "{{ BOLD + GREEN }}rebulding {{ host }}:\n\n{{ NORMAL }}"
    nixos-rebuild test --flake .#{{ host }} --sudo --impure

[group('build')]
debug host="$(hostname)":
    @printf "{{ BOLD + GREEN }}rebulding {{ host }} with debug:\n\n{{ NORMAL }}"
    nixos-rebuild test --flake .#{{ host }} --sudo --show-trace --print-build-logs --verbose

[group('build')]
rebuild-impure host="$(hostname)":
    @printf "{{ BOLD + GREEN }}rebulding {{ host }}:\n\n{{ NORMAL }}"
    nixos-rebuild switch --flake .#{{ host }} --sudo  --impure

[group('build')]
update-rebuild host="$(hostname)":
    sudo just update-all
    sudo just rebuild {{ host }}

[group('build')]
rebuild-remote config="$(hostname)" host="$(hostname)" user="$(whoami)":
    @printf "{{ BOLD + GREEN }}rebuilding {{ host }} with config {{ config }} as {{ user }}:\n\n{{ NORMAL }}"
    nixos-rebuild --target-host {{ user }}@{{ host }} switch --flake .#{{ config }} --sudo --ask-sudo-password

[group('setup')]
generate-hardware-config host="$(hostname)":
    nixos-generate-config --show-hardware-config > ./hosts/{{ host }}/hardware-configuration.nix

[group('utils')]
format:
    @printf "{{ BOLD + GREEN }}formatting files using alejandra:\n\n{{ NORMAL }}"
    alejandra .

[group('utils')]
history:
    nix profile history --profile /nix/var/nix/profiles/system

[group('utils')]
repl:
    nixos-rebuild repl --flake .

[group('cleanup')]
clean old="30":
    @printf "{{ BOLD + GREEN }}deleting history older than {{ old }} days...\n\n{{ NORMAL }}"
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than {{old}}d

[group('cleanup')]
gc old="30":
    @printf "{{ BOLD + GREEN }}collecting garbage older than {{ old }} days...\n\n{{ NORMAL }}"
    sudo nix-collect-garbage --delete-older-than {{ old }}d
    nix-collect-garbage --delete-older-than {{ old }}d


[group('cleanup')]
optimise:
    nix-store --optimise

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
