
.PHONY: all install load clean

REPO ?= $(shell pwd)

targets = $(HOME)/.bashrc \
	$(HOME)/.gtkrc-2.0.mine \
	$(HOME)/.irssi \
	$(HOME)/.libao \
	$(HOME)/.screenrc \
	$(HOME)/.Xmodmap \
	$(HOME)/.xsessionrc \
	$(HOME)/.xinitrc

i3_dir = $(HOME)/.i3
i3_repo =  $(REPO)/.i3
i3_targets = $(i3_dir)/config $(i3_dir)/startup $(i3_dir)/conkyrc

DIRS = $(i3_dir) 

all: install

install: $(targets) i3

i3: $(i3_targets)

$(i3_dir)/%: $(i3_dir)
	ln -sf $(i3_repo)/$* $@

$(HOME)/.xinitrc:
	ln -sf $(REPO)/.xsessionrc $@

$(DIRS):
	mkdir -p $@

$(HOME)/%:
	ln -sf $(REPO)/$* $@
