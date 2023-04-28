# Nix Config :snowflake:

Configuration for NixOS, macOS, and Home Manager

## Links

- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- [Setting up Home Manager with Nix Flakes](https://nix-community.github.io/home-manager/index.html#ch-nix-flakes)
- [nix-darwin supports managing Homebrew packages](https://github.com/LnL7/nix-darwin/pull/262)
- [Example showing nix-darwin managing Homebrew](https://github.com/malob/nixpkgs/blob/master/darwin/homebrew.nix)
- [Example showing nix-darwin managing macOS `defaults`](https://github.com/LnL7/nix-darwin/blob/master/modules/examples/lnl.nix)
- [brian/dotfiles.nix](https://git.bytes.zone/brian/dotfiles.nix)
- [NixOS rebuild was broken by Git CVE...](https://github.com/NixOS/nixpkgs/issues/169193)
- [MacOS `defaults` documentation](https://macos-defaults.com/screenshots/location.html)
- [Paranoid NixOS Setup](https://christine.website/blog/paranoid-nixos-2021-07-18)
- [asimpson/dotfiles](https://github.com/asimpson/dotfiles/blob/master/nixos/t480s/configuration.nix)
- [NixOS on ZFS](https://grahamc.com/blog/nixos-on-zfs)
- [Flakes: NixOS and Home Manager migration](https://gvolpe.com/blog/nix-flakes/)

## TODO

macOS updates clear /etc/zshrc back to Apple defaults; this segment was taken
from the file and should be loaded in some other way, maybe from ~/.zshrc.

```
# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix
```

Also added to ~/.zshrc was the following to have zsh exec fish instead of
setting fish as default shell:
```
if [[ $(ps -p $PPID -o comm=) != "fish" && -z ${ZSH_EXECUTION_STRING} ]]
then
    exec fish
fi
```

Should also find out what needs to be loaded from nix-darwin.

Staging area:

`sudo vifs`:
```
UUID=9609B52E-243C-413B-AB4E-6092B3A783C6 /nix apfs rw,noauto,nobrowse,suid,owners
``````
