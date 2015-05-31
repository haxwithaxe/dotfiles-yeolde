REPO ?= $(shell pwd)

trgt2src = $(subst $(HOME), $(REPO), $(1))
src2trgt = $(subst $(REPO), $(HOME), $(1))

.PHONY: all install load clean

targets = $(HOME)/.vimrc \
	$(HOME)/.playlists \
	$(HOME)/.config/pianobar/state \
	$(HOME)/.config/pianobar/config

sources = $(REPO)/.vimrc \
	$(REPO)/.config/pianobar/state \
	$(REPO)/.config/pianobar/config \
	$(REPO)/.playlists

repo_mutt_bits = $(REPO)/.mutt/gpg.rc \
  	$(REPO)/.mutt/harvest_alias.sh \
  	$(REPO)/.mutt/uirc

all: install

install: $(targets)

load: $(sources) 

$(targets):
	trgt=$@
	src=$(call trgt2src, $@)
	ln -s $(src) $(trgt)

$(HOME)/.config/pianobar: $(HOME)/.config
	mkdir -p $@

$(HOME)/.config $(HOME)/.mutt:
	mkdir -p $@

$(HOME)/.muttrc: $(home_mutt_bits)
	cp $(REPO)/.muttrc $@

$(HOME)/.config/pianobar/state: $(HOME)/.config/pianobar

$(HOME)/.config/pianobar/config: $(HOME)/.config/pianobar
	# copy not link sanitized config
	cp $(REPO)/.config/pianobar/config $@

$(sources): $(repo_mutt_bits)
	trgt=$@
	src=$(call src2trgt,$@)
	cp -r $(src) $(trgt)

$(REPO)/.config/pianobar/state: $(REPO)/.config/pianobar

$(REPO)/.config/pianobar/config: $(REPO)/.config/pianobar
	# sanitize config

$(REPO)/.config/pianobar: $(REPO)/.config
	mkdir -p $@

$(REPO)/.config:
	mkdir -p $@

$(REPO)/.muttrc:
	#sanitize muttrc

$(REPO)/.mutt:
	mkdir -p $@

$(repo_mutt_bits): $(REPO)/.mutt $(REPO)/.muttrc
