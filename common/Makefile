
.PHONY: all install load clean i3 pianobar mutt vim

REPO ?= $(shell pwd)

targets = $(HOME)/.playlists

xdg_data_dir = $(HOME)/.config
xdg_data_repo = $(REPO)/.config

vim_targets = $(HOME)/.vimrc $(HOME)/.vim

i3_dir = $(HOME)/.i3
i3_repo =  $(REPO)/.i3
i3_copy_targets = $(i3_dir)/conky-temp.sh $(i3_dir)/conky-power.sh $(i3_dir)/conky-wireless.sh $(i3_dir)/startup
i3_targets = $(i3_dir)/config $(i3_dir)/conky-i3bar $(i3_dir)/dex $(i3_dir)/libautostart.sh

pianobar_dir = $(xdg_data_dir)/pianobar
pianobar_repo = $(xdg_data_repo)/pianobar
pianobar_targets = $(pianobar_dir)/state $(pianobar_dir)/config

mutt_dir = $(HOME)/.mutt
mutt_repo = $(REPO)/.mutt
mutt_bits = $(mutt_dir)/gpg.rc $(mutt_dir)/harvest_alias.sh $(mutt_dir)/uirc

DIRS = $(pianobar_dir) $(xdg_data_dir) $(mutt_dir) $(i3_dir) 
# linked not created .playlists, .vim, .i3/dex

all: install

install: $(targets) i3 pianobar mutt vim

vim: $(vim_targets)

i3: $(i3_targets) $(i3_copy_targeets)

pianobar: $(pianobar_targets)

mutt: $(mutt_bits) $(HOME)/.muttrc

$(DIRS):
	mkdir -p $@

$(HOME)/.muttrc: $(mutt_bits)
	cp $(REPO)/.muttrc $@

$(pianobar_dir)/config: $(pianobar_dir)
	cp $(pianobar_repo)/config $@

$(pianobar_dir)/%: $(pianobar_dir)
	ln -sf $(pianobar_repo)/$* $@

$(xdg_data_dir)/%: $(xdg_data_dir)
	ln -sf $(xdg_data_repo)/$* $@

$(i3_dir)/%: $(i3_dir)
	ln -sf $(i3_repo)/$* $@

$(mutt_dir)/%:  $(mutt_dir)
	ln -sf $(mutt_repo)/$* $@

$(DIRS):
	mkdir -p $@

$(HOME)/%:
	ln -sf $(REPO)/$* $@
