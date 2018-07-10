.SHELL: /bin/bash

.PHONY: all install load clean dist-clean i3 vim-config pianobar shell-config

REPO ?= $(shell pwd)
GIT_UPDATE = git submodule update --init --recursive --remote --merge

# https://www.freedesktop.org/software/systemd/man/file-hierarchy.html
xdg_user_prefix = $(HOME)/.local
xdg_data_dir = $(HOME)/.config
xdg_repo_data_dir = $(REPO)/.config
xdg_bin_dir = $(HOME)/.local/bin
xdg_repo_bin_dir = $(REPO)/.local/bin

shell_profile_dir = $(HOME)/.profile.d
shell_profile_repo = $(REPO)/.profile.d
shell_dirs = $(shell_profile_dir) $(HOME)/.psrc.d $(HOME)/.bash_aliases.d $(HOME)/.profile.d
shell_targets = $(HOME)/.bashrc \
	bash_aliases \
	$(HOME)/.bash_completion \
	$(HOME)/.profile \
	$(HOME)/.profile.d/git-prompt.sh \
	psrc \
	vim

i3_dir = $(HOME)/.i3
i3_repo = $(REPO)/.i3
i3_targets = $(i3_dir)/conky-i3bar \
			 $(i3_dir)/conky-power \
			 $(i3_dir)/conky-temp \
			 $(i3_dir)/conky-wireless 

pianobar_dir = $(xdg_data_dir)/pianobar
pianobar_repo = $(xdg_repo_data_dir)/pianobar
pianobar_targets = $(pianobar_dir)/state \
				   $(pianobar_dir)/config \
				   $(pianobar_dir)/pianobar-ctl \
				   bash_aliases.d/pianobar-ctl

clean_targets = $(HOME)/.muttrc $(HOME)/.config/pianobar/config

TARGETS = $(HOME)/.playlists $(pianobar_targets) $(i3_targets) $(shell_targets)
DIRS = $(pianobar_dir) $(xdg_data_dir) $(i3_dir) $(shell_dirs)
# linked not created .playlists, .vim, .i3/dex

all: install

install: $(DIRS) $(TARGETS) i3 pianobar vim shell-config

update: make/.i3/dex update/.vim/bundle/jedi-vim  update/.vim/bundle/supertab  update/.vim/bundle/syntastic  update/.vim/bundle/vim-indent-guides  update/.vim/bundle/vim-surround update/.vim/vim-pathogen

UPDATE_SUBMODULES: make/.i3/dex update/.vim/bundle/jedi-vim  update/.vim/bundle/supertab  update/.vim/bundle/syntastic  update/.vim/bundle/vim-indent-guides  update/.vim/bundle/vim-surround update/.vim/vim-pathogen

MAKE_SUBMODULES: make/.i3/dex

i3: $(i3_targets) $(x_targets)

i3/autostart: i3 make/.i3/dex $(i3_dir)/libautostart.sh

bash_completion: $(HOME)/.bash_completion

pianobar: $(pianobar_dirs) $(pianobar_targets) $(HOME)/.config/pianobar/ctl

shell-config: $(shell_dirs) $(shell_targets)

psrc: psrc/base  # $(HOME)/.psrc

psrc/%:
	$(MAKE) -C $(REPO)/.psrc.d $^

vim: vim/base

vim/%:
	$(MAKE) -C $(REPO)/.vim $^

xsessionrc: xsessionrc/base  # $(HOME)/.xsessionrc

xsessionrc/%:
	$(MAKE) -C $(REPO)/.xsessionrc.d $^

pre-commit: .config/pianobar/config

clean: bash_aliases/clean psrc/clean xsessionrc/clean
	@rm -rf $(clean_targets)

$(pianobar_dir)/config: $(pianobar_dir)
	cp $(pianobar_repo)/config $@

$(HOME)/.bash_aliases.d/%: $(REPO)/.bash_aliases.d/%
	$(MAKE) -C $(REPO)/.bash_aliases.d $@

$(HOME)/.psrc.d/%: $(REPO)/.psrc.d/%
	$(MAKE) -C $(REPO)/.psrc.d $@

$(HOME)/xsessionrc.d/%: $(REPO)/.xsessionrc.d/%
	$(MAKE) -C $(REPO)/.xsessionrc.d $@

$(HOME)/.config/pianobar/ctl: $(HOME)/.config/pianobar
	mkfifo $@

$(i3_dir)/dex/dex: make/.i3/dex

$(i3_dir)/%: $(i3_dir)

$(pianobar_dir)/%: $(pianobar_dir)

$(shell_profile_dir)/%:  $(shell_profile_dir)

$(xdg_data_dir)/%: $(xdg_data_dir) $(xdg_repo_data_dir)/%

$(xdg_bin_dir)/%: $(xdg_bin_dir) $(xdg_repo_bin_dir)/%

$(DIRS):
	mkdir -p $@

$(HOME)/%: $(REPO)/%
	ln -sf $^ $@

make/%: update/%
	$(MAKE) -C $*

update/%: %
	$(GIT_UPDATE) $*
