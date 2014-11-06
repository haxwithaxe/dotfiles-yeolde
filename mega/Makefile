REPO ?= $(shell pwd)

trgt2src = $(subst $(HOME), $(REPO), $(1))
src2trgt = $(subst $(REPO), $(HOME), $(1))

.PHONY: all install load clean

targets = $(HOME)/.asoundrc \
	$(HOME)/.bashrc \
	$(HOME)/.gtkrc-2.0 \
	$(HOME)/.irssi \
	$(HOME)/.libao \
	$(HOME)/.profile \
	$(HOME)/.screenrc \
	$(HOME)/.vimrc \
	$(HOME)/.Xmodmap \
	$(HOME)/.xsessionrc \
	$(HOME)/.playlists \
	$(HOME)/.config/pianobar/state \
	$(HOME)/.config/pianobar/config

sources = $(REPO)/.asoundrc \
	$(REPO)/.bashrc \
	$(REPO)/.gtkrc-2.0 \
	$(REPO)/.irssi \
	$(REPO)/.libao \
	$(REPO)/.profile \
	$(REPO)/.screenrc \
	$(REPO)/.vimrc \
	$(REPO)/.Xmodmap \
	$(REPO)/.xsessionrc \
	$(REPO)/.config/pianobar/state \
	$(REPO)/.config/pianobar/config \
	$(REPO)/.playlists

all: install

install: $(targets)

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

$(HOME)/.config/pianobar/config:
	trgt=$@
	src=$(call trgt2src, $@)
	cp $(src) $(trgt)

$(sources): 
	trgt=$@
	src=$(call src2trgt,$@)
	cp -r $(src) $(trgt)

$(REPO)/.config/pianobar/state $(REPO)/.config/pianobar/config: $(REPO)/.config/pianobar

$(REPO)/.config/pianobar: $(REPO)/.config
	mkdir -p $@

$(REPO)/.config:
	mkdir -p $@

