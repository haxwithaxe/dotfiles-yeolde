REPO ?= $(shell pwd)

.PHONY: all install load clean .FORCE

targets = $(HOME)/.bashrc \
	$(HOME)/.gtkrc-2.0 \
	$(HOME)/.gtkrc-2.0.mine \
	$(HOME)/.profile \
	$(HOME)/.xsessionrc

i3_targets = $(HOME)/.i3/config \
	$(HOME)/.i3/conkyrc \
	$(HOME)/.i3/startup

irssi_dir = $(HOME)/.irssi
irssi_targets = $(irssi_dir)/default.theme \
	$(irssi_dir)/screwer.theme \
	$(irssi_dir)/scripts

autostart_targets =	$(HOME)/.config/autostart/nm-applet.desktop

TARGET_DIRS = $(REPO)/.i3 $(HOME)/.config/autostart $(irssi_dir)

all: install

install: $(targets) i3 autostart

i3: $(HOME)/.i3 $(i3_targets)

autostart: $(HOME)/.config/autostart $(autostart_targets)

irssi: $(irssi_dir) $(irssi_targets) $(irssi_dir)/config

on-commit: .irssi/config

$(irssi_dir)/config:
	cp .irssi/config $@

.irssi/config: .FORCE
	../sanitize irssi $(HOME)/$@ $@

$(TARGET_DIRS):
	mkdir -p $@

$(HOME)/%:
	ln -sf $(REPO)/$* $@
