# Pierce's Dotfiles

This is a [bare git repo][1] in my home directory for tracking dotfiles. It conforms to the [XDG directory standard][2].

## Dependencies

- `git`
- [`zplug`][3]

## How it was created

```bash
git init --bare "$HOME/.config/dotfiles.git"
alias dotfiles="git --git-dir=$HOME/.config/dotfiles.git --work-tree=$HOME"
dotfiles config --local status.showUntrackedFiles no
dotfiles remote add origin git@github.com:pbar1/dotfiles.git
```

## How to clone

Checkout will refuse to overwrite existing files, so make sure to delete any first. From your home directory,

```bash
git clone --bare https://github.com/pbar1/dotfiles.git "$HOME/.config/dotfiles.git"
dotfiles checkout 
```


[1]: https://news.ycombinator.com/item?id=11071754
[2]: https://wiki.archlinux.org/index.php/XDG_Base_Directory
[3]: https://github.com/zplug/zplug
