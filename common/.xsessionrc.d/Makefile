.SHELL: /bin/bash

.PHONY: all install clean

REPO ?= $(shell pwd)
INSTALL_DIR = $(HOME)/.xsessionrc.d
TARGETS = $(INSTALL_DIR)/i3.env \
	$(INSTALL_DIR)/merge-pastebuffers \
	$(INSTALL_DIR)/set-background \
	$(INSTALL_DIR)/xkb-fixes \
	$(INSTALL_DIR)/xmodmap

# Ignore Makefile
$(INSTALL_DIR)/Makefile::

all: install

base: install

install: $(TARGETS)

install/%: $(INSTALL_DIR)/%

$(INSTALL_DIR):
	mkdir -p $@

$(INSTALL_DIR)/%: $(REPO)/% $(INSTALL_DIR)
	ln -sf $(REPO)/$* $@

