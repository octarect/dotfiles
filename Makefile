DOT_PATH		:= $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

define DOTENV
export DOT_DIR=$(DOT_PATH)
export DOT_CACHE_DIR=$(HOME)/.cache/dotfiles
export DOT_LOCAL_DIR=$(HOME)/.local/dotfiles
endef

all:

init:
	@DOT_PATH=$(DOT_PATH) bash $(DOT_PATH)/etc/init.sh

deploy:
	@DOT_PATH=$(DOT_PATH) bash $(DOT_PATH)/etc/deploy.sh

export DOTENV
apply:
	@rm -f $${HOME}/.dotenv
	@echo "$${DOTENV}" | tee $${HOME}/.dotenv

install: apply init deploy
	@exec $$SHELL -l

test:
	@docker build --force-rm -t dotfiles .
	@docker container run --rm --privileged dotfiles
