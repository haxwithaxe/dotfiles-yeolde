REPO ?= $(shell pwd)

trgt2src = $(subst $(HOME), $(REPO), $(1))
src2trgt = $(subst $(REPO), $(HOME), $(1))

.PHONY: all install load clean

targets = $(HOME)/.vimrc \
	$(HOME)/.playlists

target_playlists = $(HOME)/.playlists/bbc-world_service.pls \
	$(HOME)/.playlists/podcasts \
	$(HOME)/.playlists/wamu.m3u

sources = $(REPO)/.vimrc \
	$(REPO)/.playlists

sources_playlist = $(REPO)/.playlists/bbc-world_service.pls \
	$(REPO)/.playlists/podcasts \
	$(REPO)/.playlists/wamu.m3u

all: install

install: $(targets) $(target_playliasts)

load: $(sources) $(source_playliasts)

$(targets):
	trgt=$@
	src=$(call trgt2src, $@)
	ln -s $(src) $(trgt)

$(target_playlists): $(HOME)/.playlists
	trgt=$@
	src=$(call trgt2src, $@)
	ln -s $(src) $(trgt)

$(sources): 
	trgt=$@
	src=$(call src2trgt,$@)
	cp -r $(src) $(trgt)

$(source_playlists): $(REPO)/.playlists
	trgt=$@
	src=$(call src2trgt,$@)
	cp -r $(src) $(trgt)


