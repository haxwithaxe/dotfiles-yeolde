
.PHONY: all install clean

REPO ?= $(shell pwd)

TARGETS = $(HOME)/.gtkrc-2.0.mine $(HOME)/.irssi

all: install

install: common/shell-config common/psrc/all common/vim $(TARGETS) i3 autostart

i3: common/i3 $(i3_DIR)/config $(i3_DIR)/startup

autostart: $(HOME)/.config/autostart/dropbox.desktop $(HOME)/.config/autostart/nm-applet.desktop

common/%:
	$(MAKE) -C ../common $*

$(HOME)/.i3/%: $(HOME)/.i3
	ln -sf $(REPO)/.i3/$* $@

$(HOME)/.config/autostart/%: $(HOME)/.config/autostart 
	ln -sf $(REPO)/.config/autostart/$* $@

$(HOME)/.config/autostart $(HOME)/.i3:
	mkdir -p $@

$(HOME)/%:
	ln -sf $(REPO)/$* $@
