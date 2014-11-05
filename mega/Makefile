REPO ?= $(shell pwd)

trgt2src = $(subst $(HOME), $(REPO), $(1))
src2trgt = $(subst $(REPO), $(HOME), $(1))


.PHONY: all load

all: $(HOME)/.asoundrc \
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

load: $(REPO)/.asoundrc \
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

#$(HOME)/.bashrc $(HOME)/.asoundrc $(HOME)/.gtkrc-2.0 $(HOME)/.irssi $(HOME)/.libao $(HOME)/.profile $(HOME)/.screenrc $(HOME)/.vimrc $(HOME)/.Xmodmap $(HOME)/.xsessionrc $(HOME)/.playlists $(HOME)/.synergy.conf:
#	trgt=$@
#	src=$@
#	$(call trgt2src, $(src))
#	echo src is $(src) target is $(trgt)
#	ln -s $(src) $(trgt)

#$(HOME)/.config/pianobar: $(HOME)/.config
#	mkdir -p $@

#$(HOME)/.config:
#	mkdir -p $@

#$(HOME)/.config/pianobar/state: $(HOME)/.config/pianobar
#	trgt=$@
#	src=$@
#	$(call trgt2src, $(src))
#	echo src is $(src) target is $(trgt)
#	ln -s $(src) $(trgt)
#
#$(HOME)/.config/pianobar/config: $(HOME)/.config/pianobar
#	trgt=$@
#	src=$@
#	$(call trgt2src, $(src))
#	echo src is $(src) target is $(trgt)
#	cp $(src) $(trgt)

$(REPO)/.asoundrc $(REPO)/.bashrc $(REPO)/.gtkrc-2.0 $(REPO)/.irssi $(REPO)/.libao $(REPO)/.profile $(REPO)/.screenrc $(REPO)/.vimrc $(REPO)/.Xmodmap $(REPO)/.xsessionrc $(REPO)/.playlists: 
	echo $@
	trgt=$@
	src=$(call src2trgt,$@)
	echo src is $(src) target is $(trgt)
	cp -r $(src) $(trgt)

$(REPO)/.config/pianobar/state $(REPO)/.config/pianobar/config: $(REPO)/.config/pianobar
	trgt=$@
	src=$@
	$(call trgt2src, $(src))
	echo src is $(src) target is $(trgt)
	cp -r $(src) $(trgt)

$(REPO)/.config/pianobar: $(REPO)/.config
	mkdir -p $@

$(REPO)/.config:
	mkdir -p $@

