# pbar's Dotfiles

This is a [bare git repo][1] in my home directory for tracking dotfiles. It conforms to the [XDG directory standard][2].

## Dependencies

- `git`
- `fish`
- `starship`

## How it was created

```bash
git init --bare "${HOME}/.config/dotfiles.git"
alias dotfiles="git --git-dir=${HOME}/.config/dotfiles.git --work-tree=${HOME}"
dotfiles config --local status.showUntrackedFiles no
dotfiles remote add origin git@github.com:pbar1/dotfiles.git
```

## How to clone

Checkout will refuse to overwrite existing files, so make sure to delete any first. From your home directory,

```bash
alias dotfiles="git --git-dir=${HOME}/.config/dotfiles.git --work-tree=${HOME}"
git clone --bare --recurse-submodules --jobs=8 https://github.com/pbar1/dotfiles.git "${HOME}/.config/dotfiles.git"
dotfiles checkout
```

## Design

- Terminal: Alacritty
- Terminal multiplexer: tmux (+tpm)
- Shell
  - Login: dash
  - Interactive: fish (+fisher)
- Prompt: Starship
- Editor: Neovim

### Terminal

Alacritty was chosen as the terminal for its simplicity and cross-platform support, as well as its performance. It supports Linux and macOS, the main operating systems I use.

tmux was chosen as the terminal multiplexer for its configurability and to augment Alacritty (which does not have tabs/windows).

### Shell

Previously ZSH (which is also POSIX-compliant) was used for both login and interactive shells.

Dash was chosen as the login shell for its simplicity and speed. As a POSIX-compliant `/bin/sh`, Dash provides portable way to set environment variables. It's small codebase also allows for quick execution times.

Fish was chosen for interactive shell use for its wealth of features out of the box, namely syntax highlighting and autosuggestions. These are obtainable in ZSH via plugins but did not work as well. Fish's _universal variables_ allow FZF themes to be set persistently - this is nontrivial in other shells.

Starship was chosen as the prompt for simple configuration. It also works on many different shells, making the prompt easily portable.

### Aliases & Functions

Custom functions are kept in `~/.local/bin` as executable programs. This reduces dependence on a specific shell's features, allows use of other languages (ie, Python), and improves shell loading time (as they're just programs on the PATH).

<!-- References -->

[1]: https://news.ycombinator.com/item?id=11071754
[2]: https://wiki.archlinux.org/index.php/XDG_Base_Directory
