REPO ?= $(shell pwd)

trgt2src = $(subst $(HOME), $(REPO), $(1))
src2trgt = $(subst $(REPO), $(HOME), $(1))

.PHONY: all load

targets = $(HOME)/.bashrc $(HOME)/.config/pianobar/state $(HOME)/.playlists $(HOME)/.synergy.conf $(HOME)/.xsessionrc $(HOME)/.i3

sources = $(REPO)/.bashrc $(REPO)/.config/pianobar/state $(REPO)/.playlists $(REPO)/.synergy.conf $(REPO)/.xsessionrc $(REPO)/.i3

all: $(targets)
	
load: $(sources) 

$(targets):
	trgt=$@
	src=$(call trgt2src, $@)
	ln -s $(src) $(trgt)
 
$(HOME)/.config/pianobar: $(HOME)/.config
	mkdir -p $@

$(HOME)/.config:
	mkdir -p $@

$(HOME)/.config/pianobar/state $(HOME)/.config/pianobar/config: $(HOME)/.config/pianobar

$(sources): 
	trgt=$@
	src=$(call src2trgt,$@)
	cp -r $(src) $(trgt)

$(REPO)/.config/pianobar/state $(REPO)/.config/pianobar/config: $(REPO)/.config/pianobar

$(REPO)/.config/pianobar: $(REPO)/.config
	mkdir -p $@

$(REPO)/.config:
	mkdir -p $@

