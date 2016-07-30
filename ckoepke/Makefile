REPO ?= $(shell pwd)

.PHONY: all install load clean

targets = $(HOME)/.bashrc \
	$(HOME)/.gtkrc-2.0 \
	$(HOME)/.gtkrc-2.0.mine \
	$(HOME)/.profile \
	$(HOME)/.xsessionrc

i3_targets = $(HOME)/.i3/config \
	$(HOME)/.i3/conkyrc \
	$(HOME)/.i3/startup

autostart_targets =	$(HOME)/.config/autostart/nm-applet.desktop

TARGET_DIRS = $(REPO)/.i3 $(HOME)/.config/autostart

all: install

install: $(targets) i3 autostart

i3: $(HOME)/.i3 $(i3_targets)

autostart: $(HOME)/.config/autostart $(autostart_targets)

$(TARGET_DIRS):
	mkdir -p $@

$(HOME)/%:
	ln -sf $(REPO)/$* $@
