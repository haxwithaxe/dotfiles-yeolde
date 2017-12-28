.SHELL: /bin/bash


REPO ?= $(shell pwd)/..

xsessionrcd = $(HOME)/.xsessionrc.d

TARGETS = $(xsessionrcd) \
	$(HOME)/.xsessionrc \
	$(xsessionrcd)/xkb-fixes \
	$(xsessionrcd)/merge-pastebuffers \
	$(xsessionrcd)/set-background \
	$(xsessionrcd)/xmodmap

FILES = always-on \
	disable-touchpad-on-start \
	merge-pastebuffers \
	screen-lock-advanced \
	screen-lock-basic \
	set-background \
	synaptic-mouse \
	xkb-fixes \
	xmodmap


$(FILES): % : $(xsessionrcd)/%
	echo $@ $^

DIRS = $(xsessionrcd)

all: install

install: $(DIRS) $(TARGETS)

screen-lock: $(xsessionrcd)/screen-lock-advanced

$(xsessionrcd)/screen-lock-advanced: $(xsessionrcd) $(HOME)/.xsessionrc $(user_prefix)/bin/xautolockctl

$(xsessionrcd)/%: $(xsessionrcd) $(HOME)/.xsessionrc
	ln -sf $(REPO)/.xsessionrc.d/$* $@

$(DIRS):
	mkdir -p $@

