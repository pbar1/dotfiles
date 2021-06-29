function dotfiles --wraps=git --description='Manage home directory as bare git repo'
  git --git-dir=$HOME/.config/dotfiles.git/ --work-tree=$HOME $argv;
end
