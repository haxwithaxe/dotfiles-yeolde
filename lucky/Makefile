
.PHONY: all install clean

REPO ?= $(shell pwd)

TARGETS = $(HOME)/.gtkrc-2.0.mine $(HOME)/.irssi

all: install

install: common/shell-config common/psrc/all common/vim bash_aliases $(TARGETS) i3 autostart

i3: common/i3 $(HOME)/.config/i3/config $(HOME)/.config/i3/startup

autostart: $(HOME)/.config/autostart/dropbox.desktop $(HOME)/.config/autostart/nm-applet.desktop

bash_aliases: common/bash_aliases/battery \
    common/bash_aliases/color-grep \
    common/bash_aliases/color-ls \
    common/bash_aliases/pianobar-ctl \
    common/bash_aliases/python3 \
    common/bash_aliases/screensaver \
    common/bash_aliases/venv-activate

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
