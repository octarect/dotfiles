FROM archlinux/base:latest

RUN pacman -Sy && \
    pacman -S --noconfirm make sudo gcc git gawk && \
    sed -e '/%wheel ALL=(ALL) NOPASSWD: ALL/s/^# //' /etc/sudoers | EDITOR=tee visudo >/dev/null && \
    useradd -mG wheel -s /bin/bash dotfiler

USER dotfiler
ENV USER=dotfiler
WORKDIR /home/dotfiler

ENV DOT_BRANCH=v2
CMD /usr/bin/curl https://raw.githubusercontent.com/nbitmage/dotfiles/v2/install.sh | sh

