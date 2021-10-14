FROM archlinux:base-devel

# Set working directory to be our (ie, the root user's) home directory
WORKDIR /root

# Install dependencies
RUN pacman --sync \
      --refresh --sysupgrade --noconfirm --noprogressbar \
      man git zsh starship fzf ripgrep fd neovim python nodejs zoxide bat exa

# Set our default shell
RUN chsh --shell /bin/zsh

# Clone the dotfiles straight into the home directory
RUN git clone --bare --recurse-submodules --jobs=8 https://github.com/pbar1/dotfiles.git /root/.config/dotfiles.git && \
    git --git-dir=/root/.config/dotfiles.git --work-tree=/root checkout

# Execute the shell to install plugins
RUN zsh --login --interactive

# Enable hostname in prompt so it's obvious this is running in a container,
# and set various other configs
RUN zsh --login -c 'starship toggle hostname' && \
    mkdir -p /root/.local/share/zsh/

# Configure this image's entrypoint to be a login shell
ENTRYPOINT [ "/bin/zsh" ]
CMD [ "--login" ]
