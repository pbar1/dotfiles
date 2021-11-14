#------------------------------------------------------------------------------
# Download container
#------------------------------------------------------------------------------

FROM alpine:edge as download

WORKDIR /dl

RUN wget -O - https://github.com/starship/starship/releases/download/v1.0.0/starship-x86_64-unknown-linux-musl.tar.gz | tar -xz && \
    chmod +x starship
RUN wget -O - https://github.com/rossmacarthur/sheldon/releases/download/0.6.5/sheldon-0.6.5-x86_64-unknown-linux-musl.tar.gz | tar -xz && \
    chmod +x sheldon

#------------------------------------------------------------------------------
# Main container
#------------------------------------------------------------------------------

FROM alpine:edge
LABEL org.opencontainers.image.authors "Pierce Bartine <pbar1@users.noreply.github.com>"
LABEL org.opencontainers.image.source "https://github.com/pbar1/dotfiles"

# Set working directory to be our (ie, the root user's) home directory
WORKDIR /root

# Install dependencies
RUN apk update && \
    apk add --no-cache \
      man-db git zsh fzf ripgrep fd neovim python3 nodejs zoxide bat exa bash perl
COPY --from=download /dl/starship /usr/local/bin/
COPY --from=download /dl/sheldon  /usr/local/bin/

# Clone the dotfiles straight into the home directory
RUN git clone --bare --recurse-submodules --jobs=8 https://github.com/pbar1/dotfiles.git /root/.config/dotfiles.git && \
    git --git-dir=/root/.config/dotfiles.git --work-tree=/root checkout

# Tweak some things to allow our shell to work properly in a minimal environment
RUN sed -i '/gpgconf/s/^/#/g' /root/.config/zsh/.zshrc && \
    mkdir -p /root/.local/share/zsh/

# Execute the shell to install plugins
RUN zsh --login --interactive

# Enable hostname in prompt so it's obvious this is running in a container
RUN zsh --login -c 'starship toggle hostname'

# Configure this image's entrypoint to be a login shell
ENTRYPOINT ["/bin/zsh"]
CMD ["--login"]
