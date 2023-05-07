# frozen_string_literal: true

# TODO: Support CLI args passthru
# TODO: Resolve default namespace task to current hostname default task

# Variables -------------------------------------------------------------------

hostname = `hostname -s`.strip
pwd = `pwd`.strip

# [Tasks] Utility -------------------------------------------------------------

desc 'Print hostname to be used for flake evaluations'
task :hostname do
  puts hostname
end

desc 'Format code in this project'
task :fmt do
  sh 'nix run nixpkgs#rubocop -- --autocorrect Rakefile'
  sh 'nixpkgs-fmt .'
  sh 'stylua .'
end

# [Tasks] Nix -----------------------------------------------------------------

namespace :nix do
  task default: [:repl]

  desc 'Install Nix'
  task :install do
    sh 'curl --proto \'=https\' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install'
  end

  desc 'Uninstall Nix'
  task :uninstall do
    sh '/nix/nix-installer uninstall'
  end

  desc 'Launch a Nix repl'
  task :repl do
    puts 'To load flake config, type `:lf .#` in the repl'
    sh 'nix repl'
  end

  desc 'Update Nix flake inputs and flake.lock'
  task :update do
    sh 'nix flake update'
  end

  desc 'Download Nix flake inputs to the Nix store'
  task :archive do
    sh 'nix flake archive'
  end

  desc 'Remove all unused objects from Nix store'
  task :gc do
    sh 'nix-collect-garbage --delete-old'
    sh 'sudo nix-collect-garbage --delete-old'
  end
end

task nix: ['nix:default']

# [Tasks] NixOS ---------------------------------------------------------------

namespace :nixos do
  task default: [:switch]

  desc 'Compile and activate NixOS config'
  task :switch do
    sh "nixos-rebuid switch --use-remote-sudo --flake '.##{hostname}'"
  end

  desc 'Compile and activate NixOS config (tec)'
  task :switch_tec do
    sh "rsync --recursive --exclude='.git*' --filter='dir-merge,- .gitignore' #{pwd}/* nixos@192.168.0.5:~/nix-config"
    sh "ssh nixos@192.168.0.5 'nixos-rebuild switch --use-remote-sudo --flake ~/nix-config#tec'"
  end
end

task nixos: ['nixos:switch']

# [Tasks] nix-darwin ----------------------------------------------------------

namespace :darwin do
  task default: [:switch]

  desc 'Install nix-darwin'
  task :install do
    sh "nix build '.#darwinConfigurations.#{hostname}.system'"
    sh './result/sw/bin/darwin-rebuild switch --flake .#'
  end

  desc 'Compile and activate nix-darwin config'
  task :switch do
    sh '/run/current-system/sw/bin/darwin-rebuild switch --flake .#'
  end
end

task darwin: ['darwin:default']

# [Tasks] Home Manager --------------------------------------------------------

namespace :home do
  task default: [:switch]

  desc 'Install Home Manager'
  task :install do
    sh "nix run '.#homeConfigurations.#{hostname}.activationPackage'"
  end

  desc 'Compile and activate Home Manager config'
  task :switch do
    sh "home-manager switch --flake '.##{hostname}'"
  end

  # TODO: Add dynamism to Neovim config to load this if needed, maybe with Lazy.nvim
  desc 'Compile and activate Home Manager config (devvm)'
  task :switch_devvm do
    sh 'sed -i \'s|#"vim:meta.nvim"|"vim:meta.nvim"|g\' flake.nix'
    sh 'home-manager --extra-experimental-features "nix-command flakes" switch --flake ".#devserver"'
    sh 'sed -i \'s|[^#]"vim:meta.nvim"| #"vim:meta.nvim"|g\' flake.nix'
  end
end

task home: ['home:default']

# [Tasks] Defaults ------------------------------------------------------------

task :default do
  sh 'rake --tasks', verbose: false
end

task update: ['nix:update']

task gc: ['nix:gc']
