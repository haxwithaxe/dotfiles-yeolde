.SHELL: /bin/bash

.PHONY: all install load clean dist-clean i3 vim-config pianobar shell-config

REPO ?= $(shell pwd)
GIT_UPDATE = git submodule update --recursive --remote --merge

xdg_data_dir = $(HOME)/.config
xdg_repo_dir = $(REPO)/.config

# vim_dir is linked no need to have any targets inside it besides those
#   required for pathogen
vim_dir = $(HOME)/.vim
vim_repo = $(REPO)/.vim
vim_targets = $(HOME)/.vim/autoload/pathogen.vim $(HOME)/.vimrc
vim_dirs = $(HOME)/.vim/autoload

shell_profile_dir = $(HOME)/.profile.d
shell_profile_repo = $(REPO)/.profile.d
shell_dirs = $(shell_profile_dir) $(HOME)/.psrc.d $(HOME)/.bash_aliases.d
shell_targets = $(HOME)/.bashrc $(HOME)/.bash_aliases $(HOME)/.psrc $(HOME)/.psrc.d/00-bashrc $(HOME)/.psrc.d/00-git $(HOME)/.psrc.d/01-smallpwd $(HOME)/.profile $(HOME)/.profile.d/git-prompt.sh

i3_dir = $(HOME)/.i3
i3_repo = $(REPO)/.i3
i3_targets = $(i3_dir)/conky-i3bar $(i3_dir)/dex $(i3_dir)/libautostart.sh $(i3_dir)/conky-power $(i3_dir)/conky-wireless $(i3_dir)/conky-temp

pianobar_dir = $(xdg_data_dir)/pianobar
pianobar_repo = $(xdg_repo_dir)/pianobar
pianobar_targets = $(pianobar_dir)/state $(pianobar_dir)/config $(pianobar_dir)/pianobar-ctl $(HOME)/.bash_aliases.d/pianobar-ctl

clean_targets = $(HOME)/.muttrc $(HOME)/.config/pianobar/config $(REPO)/.vim/vim-pathogen/autoload/pathogen.vim

TARGETS = $(HOME)/.playlists $(pianobar_targets) $(i3_targets) $(vim_targets) $(shell_targets)
DIRS = $(pianobar_dir) $(xdg_data_dir) $(i3_dir) $(vim_dirs) $(shell_dirs)
# linked not created .playlists, .vim, .i3/dex

all: install

install: $(DIRS) $(TARGETS) i3 pianobar vim shell-config

UPDATE_SUBMODULES: .i3/dex update/.vim/bundle/jedi-vim  update/.vim/bundle/supertab  update/.vim/bundle/syntastic  update/.vim/bundle/vim-indent-guides  update/.vim/bundle/vim-surround update/.vim/vim-pathogen

MAKE_SUBMODULES: .i3/dex/dex

vim: $(vim_dir) vim-config

i3: $(i3_targets)

pianobar: $(pianobar_dirs) $(pianobar_targets) $(HOME)/.config/pianobar/ctl

vim-config: $(vim_dir) $(vim_targets)

shell-config: $(shell_dirs) $(shell_targets)

pre-commit: .config/pianobar/config

clean:
	@rm -rf $(clean_targets)

$(i3_dir)/dex/dex: .i3/dex/dex

.i3/dex/dex: make/.i3/dex

$(pianobar_dir)/config: $(pianobar_dir)
	cp $(pianobar_repo)/config $@

.config/pianobar/config: .FORCE
	../sanitize $(pianobar_repo)/config $@
	
$(vim_dir)/autoload/pathogen.vim: .vim/autoload/pathogen.vim
	ln -sf $(vim_repo)/vim-pathogen/autoload/pathogen.vim $@

.vim/autoload/pathogen.vim: .vim/autoload .vim/vim-pathogen/autoload/pathogen.vim
	ln -sf $(vim_repo)/vim-pathogen/autoload/pathogen.vim $@

.vim/vim-pathogen/autoload/pathogen.vim: update/.vim/vim-pathogen

$(HOME)/.config/pianobar/ctl:
	mkfifo $@

$(i3_dir)/%: $(i3_dir)
	ln -sf $(i3_repo)/$* $@

$(pianobar_dir)/%: $(pianobar_dir)
	ln -sf $(pianobar_repo)/$* $@

$(shell_profile_dir)/%:  $(shell_profile_dir)
	ln -sf $(shell_profile_repo)/$* $@


$(vim_dir)/%:  $(vim_dir)
	ln -sf $(vim_repo)/$* $@

$(xdg_data_dir)/%: $(xdg_data_dir)
	ln -sf $(xdg_data_repo)/$* $@

$(DIRS):
	mkdir -p $@

$(HOME)/%:
	ln -sf $(REPO)/$* $@

make/%: update/%
	$(MAKE) -C $*

update/%:
	$(GIT_UPDATE) $*

