FROM archlinux/base:latest

RUN pacman -Sy && \
    pacman -S --noconfirm make sudo gcc git gawk jq && \
    sed -e '/%wheel ALL=(ALL) NOPASSWD: ALL/s/^# //' /etc/sudoers | EDITOR=tee visudo >/dev/null && \
    useradd -mG wheel -s /bin/bash dotfiler

ADD . /home/dotfiler/dotfiles

USER dotfiler
ENV USER=dotfiler

WORKDIR /home/dotfiler/dotfiles

ENV DOT_BRANCH=master

CMD cat /home/dotfiler/dotfiles/install.sh | bash
