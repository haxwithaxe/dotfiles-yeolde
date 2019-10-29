.SHELL: /bin/bash

.PHONY: all install clean base
.DEFAULT: all

REPO ?= $(shell pwd)
INSTALL_DIR = $(HOME)/.bash_aliases.d
BASE_TARGETS = $(INSTALL_DIR)/color-grep \
	$(INSTALL_DIR)/color-ls \
	$(INSTALL_DIR)/derp \
	$(INSTALL_DIR)/python3 \
	$(INSTALL_DIR)/venv-activate
TARGETS = $(BASE_TARGETS) $(INSTALL_DIR)/pianobar-ctl

all: install
	echo "goal $(MAKECMDGOALS)"

base: $(BASE_TARGETS)

install: $(TARGETS)

install/%: $(INSTALL_DIR)/%

clean:
	rm $(TARGETS)

dist-clean: clean

$(INSTALL_DIR): $(HOME)/.bash_aliases
	mkdir -p $@

$(INSTALL_DIR)/%: $(INSTALL_DIR) $(REPO)/%
	ln -sf $(REPO)/$* $@

