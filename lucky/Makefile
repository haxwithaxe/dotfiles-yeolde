REPO ?= $(shell pwd)

.PHONY: all install clean

TARGETS = $(HOME)/.bashrc \
	$(HOME)/.gtkrc-2.0.mine \
	$(HOME)/.irssi \
	$(HOME)/.profile \
	$(HOME)/.psrc

i3_REPO = $(REPO)/.i3
i3_DIR = $(HOME)/.i3
i3_TARGETS = $(i3_DIR)/config \
	$(i3_DIR)/startup

AUTOSTART_REPO = $(REPO)/.config/autostart
AUTOSTART_DIR = $(HOME)/.config/autostart
AUTOSTART_TARGETS = $(AUTOSTART_DIR)/dropbox.desktop \
	$(AUTOSTART_DIR)/nm-applet.desktop

DIRS = $(i3_DIR) $(AUTOSTART_DIR)

all: install

install: $(TARGETS) i3 autostart

i3: $(i3_DIR) $(i3_TARGETS)

autostart: $(AUTOSTART_DIR) $(AUTOSTART_TARGETS)

$(i3_DIR)/%: $(i3_DIR)
	ln -sf $(i3_REPO)/$* $@

$(AUTOSTART_DIR)/%: $(AUTOSTART_DIR)
	ln -sf $(AUTOSTART_REPO)/$* $@

$(DIRS):
	mkdir -p $@

$(HOME)/%:
	ln -sf $(REPO)/$* $@
