.SHELL: /bin/bash

.PHONY: all install clean base

REPO ?= $(shell pwd)
INSTALL_DIR = $(HOME)/.bash_aliases.d
BASE_TARGETS = $(INSTALL_DIR)/color-grep \
	$(INSTALL_DIR)/color-ls \
	$(INSTALL_DIR)/derp \
	$(INSTALL_DIR)/python3 \
	$(INSTALL_DIR)/venv-activate
TARGETS = $(BASE_TARGETS) $(INSTALL_DIR)/pianobar-ctl

all: install

$(INSTALL_DIR)/Makefile::

base: $(BASE_TARGETS)

install: $(TARGETS)

install/%: $(REPO)/%
	ln -sf $(REPO)/$* $(INSTALL_DIR)/$*

clean:
	rm $(TARGETS)

dist-clean: clean

$(INSTALL_DIR): $(HOME)/.bash_aliases
	mkdir -p $@

$(INSTALL_DIR)/%: $(INSTALL_DIR)
	ln -sf $(REPO)/$* $@

