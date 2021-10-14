FROM archlinux:base-devel

WORKDIR /root

RUN pacman --sync \
      --refresh --sysupgrade --noconfirm --noprogressbar \
      man git zsh starship fzf ripgrep fd neovim python nodejs zoxide bat exa

RUN chsh --shell /bin/zsh

RUN git clone --bare --recurse-submodules --jobs=8 https://github.com/pbar1/dotfiles.git /root/.config/dotfiles.git && \
    git --git-dir=/root/.config/dotfiles.git --work-tree=/root checkout

RUN zsh --login --interactive



# ENTRYPOINT [ "/bin/zsh" ]
# CMD [ "--login" ]
