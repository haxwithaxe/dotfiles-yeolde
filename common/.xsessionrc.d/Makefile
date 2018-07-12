.SHELL: /bin/bash

.PHONY: all install clean

REPO ?= $(shell pwd)
INSTALL_DIR = $(HOME)/.xsessionrc.d
TARGETS = $(INSTALL_DIR)/xkb-fixes \
	$(INSTALL_DIR)/merge-pastebuffers \
	$(INSTALL_DIR)/set-background \
	$(INSTALL_DIR)/xmodmap

FILES = always-on \
	disable-touchpad-on-start \
	merge-pastebuffers \
	set-background \
	synaptic-mouse \
	xkb-fixes \
	xmodmap

all: install

base: install

install: $(TARGETS)

$(INSTALL_DIR): $(HOME)/.xsessionrc
	mkdir -p $@

$(INSTALL_DIR)/%: $(INSTALL_DIR)
	ln -sf $(REPO)/$* $@

