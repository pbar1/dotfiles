# Dotfiles :house:

[This is a bare git repo in my home directory for tracking dotfiles][1]

### `dotfiles` alias
```bash
alias dotfiles='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
# after cloning or initial config...
dotfiles config --local status.showUntrackedFiles no
```

### Initial config
```bash
git init --bare $HOME/.dotfiles.git
dotfiles remote add origin git@github.com:pbar1/.dotfiles.git
```

### When cloning
```bash
git clone --bare git@github.com:pbar1/.dotfiles.git $HOME/.dotfiles.git
dotfiles checkout 
```
Checkout will refuse to overwrite existing files, so make sure to delete any first

## Notes

#### Squash last N commits
In this case, `HEAD~3` means the last 3 commits
```sh
git reset --soft HEAD~3 && 
git commit --edit -m"$(git log --format=%B --reverse HEAD..HEAD@{1})"
```
Then,
```sh
git push origin +<branch>
```

[1]: https://news.ycombinator.com/item?id=11071754
