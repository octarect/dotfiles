DOT_DIR		:= $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
ARG			=

define DOTENV
export DOT_DIR=$(DOT_DIR)
export DOT_CACHE_DIR=$(HOME)/.cache/dotfiles
export DOT_LOCAL_DIR=$(HOME)/.local/dotfiles
endef

all:

init:
	bash $(DOT_DIR)/etc/init.sh $(ARG)

deploy:
	bash $(DOT_DIR)/etc/deploy.sh

export DOTENV
apply:
	@rm -f $${HOME}/.dotenv
	@echo "$${DOTENV}" | tee $${HOME}/.dotenv

install: apply init deploy
	@exec $$SHELL -l

test:
	@docker build --force-rm -t dotfiles .
	@docker container run --rm --privileged dotfiles
