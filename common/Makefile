.SHELL: /bin/bash

.PHONY: all install load clean dist-clean i3 vim-config pianobar shell-config

REPO ?= $(shell pwd)

# https://www.freedesktop.org/software/systemd/man/file-hierarchy.html
xdg_user_prefix = $(HOME)/.local
xdg_repo_user_prefix = $(REPO)/.local
xdg_data_dir = $(HOME)/.config
xdg_data_repo = $(REPO)/.config
xdg_bin_dir = $(xdg_user_prefix)/.local/bin
xdg_bin_repo = $(xdg_repo_user_prefix)/.local/bin

shell_profile_dir = $(HOME)/.profile.d
shell_profile_repo = $(REPO)/.profile.d
shell_dirs = $(shell_profile_dir) $(HOME)/.psrc.d $(HOME)/.bash_aliases.d
shell_targets = $(HOME)/.bashrc \
	bash_aliases \
	bash_completion \
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
pianobar_repo = $(xdg_data_repo)/pianobar
pianobar_targets = $(pianobar_dir)/state \
				   $(pianobar_dir)/config \
				   $(pianobar_dir)/pianobar-ctl \
				   $(pianobar_dir)/ctl \
				   bash_aliases/pianobar-ctl

clean_targets = $(HOME)/.muttrc $(HOME)/.config/pianobar/config

TARGETS = $(HOME)/.playlists $(pianobar_targets) $(i3_targets) $(shell_targets)
DIRS = $(pianobar_dir) $(xdg_data_dir) $(i3_dir) $(shell_dirs)
# linked not created .playlists, .vim

all: install

install: $(DIRS) $(TARGETS) i3 pianobar vim shell-config

update: update/.vim/bundle/jedi-vim  update/.vim/bundle/supertab  update/.vim/bundle/syntastic  update/.vim/bundle/vim-indent-guides  update/.vim/bundle/vim-surround update/.vim/vim-pathogen

UPDATE_SUBMODULES: make/.i3/dex vim/update/jedi-vim vim/update/supertab vim/update/syntastic vim/update/vim-indent-guides vim/update/vim-surround vim/update/vim-pathogen

MAKE_SUBMODULES: make/.i3/dex

i3: $(i3_targets) $(x_targets)

i3/autostart: i3 make/.i3/dex $(i3_dir)/libautostart.sh

bash_completion: $(HOME)/.bash_completion

pianobar: $(pianobar_dirs) $(pianobar_targets)

shell-config: $(shell_dirs) $(shell_targets)

xsessionrc: $(HOME)/.xsessionrc $(x_targets)

xsessionrc/%: $(xsessionrcd)/%
	echo $@

screen-lock: $(xsessionrcd)/screen-lock-advanced

bash_aliases: bash_aliases/base

bash_aliases/%:
	$(MAKE) -C $(REPO)/.bash_aliases.d $*

psrc: psrc/base

psrc/%:
	$(MAKE) -C $(REPO)/.psrc.d $^

vim: vim/base

vim/%:
	$(MAKE) -C $(REPO)/.vim $*

xsessionrc: xsessionrc/base

$(HOME)/.psrc.d/%:
	$(MAKE) -C $(REPO)/.psrc.d $@

pre-commit: $(REPO)/.config/pianobar/config

clean: bash_aliases/clean psrc/clean xsessionrc/clean
	@rm -rf $(clean_targets)

$(i3_dir)/%: $(i3_dir) $(i3_repo)/%
	ln -sf $(i3_repo)/$* $@

$(pianobar_dir)/%: $(pianobar_dir) $(pianobar_repo)/%
	ln -sf $(pianobar_repo)/$* $@

$(shell_profile_dir)/%: $(shell_profile_dir) $(shell_profile_repo)/%
	ln -sf $(shell_profile_repo)/$* $@

$(xdg_data_dir)/%: $(xdg_data_dir) $(xdg_data_repo)/%
	ln -sf $(xdg_data_repo)/$* $@

$(xdg_bin_dir)/%: $(xdg_bin_dir) $(xdg_bin_repo)/%
	ln -sf $(xdg_bin_repo)/$* $@

$(xsessionrcd)/%: $(xsessionrcd) $(HOME)/.xsessionrc $(REPO)/.xsessionrc.d/% 
	ln -sf $(REPO)/.xsessionrc.d/$* $@

# Copy the config so that is doesn't contaminate the repo
$(pianobar_dir)/config: $(pianobar_dir)
	cp $(pianobar_repo)/config $@

$(HOME)/.bash_aliases.d/%: $(REPO)/.bash_aliases.d/%
	$(MAKE) -C $(REPO)/.bash_aliases.d $@

$(HOME)/.psrc.d/%: $(REPO)/.psrc.d/%
	$(MAKE) -C $(REPO)/.psrc.d $@

$(HOME)/xsessionrc.d/%: $(REPO)/.xsessionrc.d/%
	$(MAKE) -C $(REPO)/.xsessionrc.d $@

$(pianobar_dir)/ctl: $(pianobar_dir)
	mkfifo $@

$(i3_dir)/dex/dex: make/.i3/dex

$(DIRS):
	mkdir -p $@

$(HOME)/%:
	echo $@
	ln -sf $(REPO)/$* $@

make/%: update/%
	$(MAKE) -C $*

update/%: %
	git submodule update --init --recursive --remote --merge $*
