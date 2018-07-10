.SHELL: /bin/bash

.PHONY: all install clean

REPO ?= $(shell pwd)
INSTALL_DIR ?= $(HOME)/.psrc.d
BASH_LOADABLE_DIR ?= /usr/lib/bash

TARGETS = $(INSTALL_DIR)/00-color \
	$(INSTALL_DIR)/00-git \
	$(INSTALL_DIR)/01-smallpwd \
	$(INSTALL_DIR)/02-venv


all: install

install: $(TARGETS)

clean:
	@rm -rf $(TARGETS)

# Special case: bash loadables (Debian package "bash-builtins") are required
$(INSTALL_DIR)/02-venv: $(BASH_LOADABLE_DIR)/basename $(BASH_LOADABLE_DIR)/dirname

$(INSTALL_DIR):
	mkdir -p $@

$(INSTALL_DIR)/%: $(INSTALL_DIR) $(REPO)/%
	ln -sf $(REPO)/$* $@

