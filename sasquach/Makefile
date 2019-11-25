
.PHONY: all install clean

REPO ?= $(shell pwd)

TARGETS = $(HOME)/.psrc.d/conf

all: install

install: common/shell-config common/psrc/all common/neovim $(TARGETS)

common/%:
	$(MAKE) -C ../common $*

$(HOME)/%:
	ln -sf $(REPO)/$* $@
