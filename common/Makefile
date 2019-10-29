.SHELL: /bin/bash

.PHONY: all install load clean dist-clean i3 vim-config pianobar shell-config MAKE_SUBMODULES

REPO ?= $(shell pwd)

# https://www.freedesktop.org/software/systemd/man/file-hierarchy.html
export xdg_user_prefix = $(HOME)/.local
export xdg_repo_user_prefix = $(REPO)/.local
export xdg_data_dir = $(HOME)/.config
export xdg_data_repo = $(REPO)/.config
export xdg_bin_dir = $(xdg_user_prefix)/.local/bin
export xdg_bin_repo = $(xdg_repo_user_prefix)/.local/bin

shell_profile_dir = $(HOME)/.profile.d
shell_profile_repo = $(REPO)/.profile.d
shell_dirs = $(shell_profile_dir) $(HOME)/.psrc.d $(HOME)/.bash_aliases.d $(HOME)/.bashrc.d
shell_targets = $(HOME)/.bashrc \
	bash_aliases \
	bash_completion \
	$(HOME)/.profile \
	psrc \
	vim

i3_dir = $(xdg_data_dir)/i3
i3_repo = $(REPO)/.i3
i3_targets = $(i3_dir)/conky-i3bar $(i3_dir)/conkyrc $(i3_dir)/i3-conky-modules

clean_targets = $(HOME)/.muttrc

TARGETS = $(HOME)/.playlists pianobar $(i3_targets) $(shell_targets)
DIRS = $(pianobar_dir) $(xdg_data_dir) $(i3_dir) $(shell_dirs)
# linked not created .playlists, .vim

all: install

install: $(DIRS) $(TARGETS) i3 pianobar vim shell-config

update: update/.vim/bundle/jedi-vim update/.vim/bundle/supertab update/.vim/bundle/syntastic update/.vim/bundle/vim-indent-guides update/.vim/bundle/vim-surround update/.vim/vim-pathogen

UPDATE_SUBMODULES: vim/update/jedi-vim vim/update/supertab vim/update/syntastic vim/update/vim-indent-guides vim/update/vim-surround vim/update/vim-pathogen 

make/%: update/%
	$(MAKE) -C $*

update/.vim/bundle/vim-jsbeautify:
	git submodule update --init --remote --merge .vim/bundle/vim-jsbeautify

update/%: %
	git submodule update --init --recursive --remote --merge $*

clean: bash_aliases/clean pianobar/clean psrc/clean xsessionrc/clean
	@rm -rf $(clean_targets)

bash_aliases: $(HOME)/.bash_aliases bash_aliases/base

bash_aliases/%:
	echo "target: bash_aliases/$* /// goals: $(MAKECMDGOALS) /// carret: $^"
	$(MAKE) -C $(REPO)/.bash_aliases.d $*

bash_completion: $(HOME)/.bash_completion

bashrc: $(HOME)/.bashrc $(HOME)/.bashrc.d

i3: $(i3_targets) $(x_targets)

i3/autostart: i3 $(i3_dir)/libautostart.sh

# NeoVIM doesn't look for the VIM config on its own
# It does look for $(xdg_data_dir)/nvim/init.vim which now points to the vim config
nvim neovim: vim $(xdg_data_dir)/nvim $(xdg_data_dir)/nvim/init.vim

pianobar: pianobar/all $(HOME)/.bash_aliases bash_aliases/pianobar-ctl

pianobar/%:
	$(MAKE) -C .config/pianobar $*

psrc: psrc/base

psrc/%:
	$(MAKE) -C $(REPO)/.psrc.d $^

screen-lock: $(xsessionrcd)/screen-lock-advanced

shell-config: $(shell_dirs) $(shell_targets)

vim: vim/base

vim/%:
	$(MAKE) -C $(REPO)/.vim $*

xsessionrc: xsessionrc/base

xsessionrc/%: $(xsessionrcd)/%
	echo $@

$(HOME)/.bash_aliases.d/%: $(REPO)/.bash_aliases.d/%
	$(MAKE) -C $(REPO)/.bash_aliases.d $@

$(HOME)/.config/pianobar/%: $(REPO)/.config/pianobar/%
	$(MAKE) -C $(REPO)/.config/pianobar $@

$(HOME)/.psrc.d/%: $(REPO)/.psrc.d/%
	$(MAKE) -C $(REPO)/.psrc.d $@

$(HOME)/xsessionrc.d/%: $(REPO)/.xsessionrc.d/%
	$(MAKE) -C $(REPO)/.xsessionrc.d $@

$(i3_dir)/%: $(i3_dir) $(i3_repo)/%
	ln -sf $(i3_repo)/$* $@

$(shell_profile_dir)/%: $(shell_profile_dir) $(shell_profile_repo)/%
	ln -sf $(shell_profile_repo)/$* $@

$(xdg_data_dir)/%: $(xdg_data_dir) $(xdg_data_repo)/%
	ln -sf $(xdg_data_repo)/$* $@

$(xdg_bin_dir)/%: $(xdg_bin_dir) $(xdg_bin_repo)/%
	ln -sf $(xdg_bin_repo)/$* $@

$(xsessionrcd)/%: $(xsessionrcd) $(HOME)/.xsessionrc $(REPO)/.xsessionrc.d/% 
	ln -sf $(REPO)/.xsessionrc.d/$* $@

$(DIRS):
	mkdir -p $@

$(HOME)/%:
	echo $@
	ln -sf $(REPO)/$* $@
