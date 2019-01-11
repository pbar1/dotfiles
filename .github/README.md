# Dotfiles :house:

[This is a bare git repo in my home directory for tracking dotfiles][1]

```bash
git init --bare $HOME/.config/dotfiles.git
alias dotfiles="git --git-dir=$HOME/.config/dotfiles.git --work-tree=$HOME"
dotfiles config --local status.showUntrackedFiles no
dotfiles remote add origin git@github.com:pbar1/dotfiles.git
```

### When cloning
```bash
# from your home directory...
git clone --bare git@github.com:pbar1/dotfiles.git $HOME/.config/dotfiles.git
dotfiles checkout 
```
Checkout will refuse to overwrite existing files, so make sure to delete any first


[1]: https://news.ycombinator.com/item?id=11071754
