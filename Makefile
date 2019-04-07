DOT_PATH		:= $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
TMP_PATH		:= $(DOT_PATH)/tmp

all:

init:
	@DOT_PATH=$(DOT_PATH) $(DOT_PATH)/etc/init.sh

deploy:
	@DOT_PATH=$(DOT_PATH) $(DOT_PATH)/etc/deploy.sh

install: init deploy
	@exec $$SHELL
