set quiet

default:
    just --list

[group('nix')]
nix-repl:
    echo 'To load flake config, type `:lf .#` in the repl'
    nix repl