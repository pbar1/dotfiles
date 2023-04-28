hostname = `hostname -s`.strip()

task :print_hostname do
  puts hostname
end

task :install_nix do
  sh 'curl --proto \'=https\' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install'
end

task :uninstall_nix do
  sh '/nix/nix-installer uninstall'
end

task :install_darwin do
  sh "nix build '.#darwinConfigurations.#{hostname}.system'"
  sh './result/sw/bin/darwin-rebuild switch --flake .#'
end

task :install_homemanager do
  sh "nix run '.#homeConfigurations.#{hostname}.activationPackage'"
end

# FIXME: Support CLI args passthru
task :home do
  sh "home-manager switch --flake '.##{hostname}'"
end
