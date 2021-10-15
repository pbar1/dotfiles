FROM alpine:edge
LABEL org.opencontainers.image.authors "Pierce Bartine <pbar1@users.noreply.github.com>"
LABEL org.opencontainers.image.source "https://github.com/pbar1/dotfiles"

# Set working directory to be our (ie, the root user's) home directory
WORKDIR /root

# Install dependencies
RUN apk update && \
    apk add --no-cache \
      man-db git zsh starship fzf ripgrep fd neovim python3 nodejs zoxide bat exa bash perl

# Clone the dotfiles straight into the home directory
RUN git clone --bare --recurse-submodules --jobs=8 https://github.com/pbar1/dotfiles.git /root/.config/dotfiles.git && \
    git --git-dir=/root/.config/dotfiles.git --work-tree=/root checkout

# Tweak some things to allow our shell to work properly in an minimal environment
RUN sed -i '/gpgconf/s/^/#/g' /root/.profile && \
    mkdir -p /root/.local/share/zsh/

# Execute the shell to install plugins
RUN zsh --login --interactive

# Enable hostname in prompt so it's obvious this is running in a container
RUN zsh --login -c 'starship toggle hostname'

# Configure this image's entrypoint to be a login shell
ENTRYPOINT [ "/bin/zsh" ]
CMD [ "--login" ]
