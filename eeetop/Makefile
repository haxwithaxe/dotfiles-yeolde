
REPO ?= $(shell pwd)

.PHONY: all

all: $(HOME)/.bashrc $(HOME)/.config/pianobar/state $(HOME)/.config/pianobar/state $(HOME)/.playlists $(HOME)/.synergy.conf 

$(HOME)/.bashrc:
	ln -s $(REPO)/.bashrc $@

$(HOME)/.config/pianobar:
	    mkdir -p $@

$(HOME)/.config/pianobar/state: $(HOME)/.config/pianobar
	ln -s $(REPO)/.config/pianobar/state $@

$(HOME)/.config/pianobar/config: $(HOME)/.config/pianobar
	cp $(REPO)/.config/pianobar/config $@

$(HOME)/.playlists:
	ln -s $(REPO)/.playlists $@

$(HOME)/.synergy.conf:
	ln -s $(REPO)/.synergy.conf $@
