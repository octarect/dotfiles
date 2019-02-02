#!/usr/bin/env zsh

alias nvimconfig="nvim -p ${XDG_CONFIG_HOME}/nvim/init.vim ${XDG_CONFIG_HOME}/nvim/dein.toml ${XDG_CONFIG_HOME}/nvim/dein.lazy.toml"

alias opensessame='nvim -p $(cat .init_open)'
