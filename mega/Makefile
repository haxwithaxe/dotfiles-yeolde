
.PHONY: all install load clean

REPO ?= $(shell pwd)

TARGETS = $(HOME)/.bashrc \
	$(HOME)/.gtkrc-2.0.mine \
	$(HOME)/.Xmodmap \
	$(HOME)/.i3/config \
	$(HOME)/.i3/startup \
	$(HOME)/.i3/conkyrc
DIRS = $(HOME)/.i3

all: install

install: $(TARGETS) i3 shell common/bash_aliases/venv-activate

shell: common/shell-config common/bash_completion common/bash_aliases common/psrc/all common/vim

i3: common/i3 \
	$(HOME)/.i3/config \
	$(HOME)/.i3/startup \
	$(HOME)/.i3/conkyrc \
	common/xsessionrc

common/%:
	$(MAKE) -C ../common $*

$(HOME)/.xinitrc:
	ln -sf $(REPO)/.xsessionrc $@

$(DIRS):
	mkdir -p $@

$(HOME)/%:
	ln -sf $(REPO)/$* $@
