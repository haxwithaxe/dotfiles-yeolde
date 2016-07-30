
.PHONY: all install load clean dist-clean i3 vim-config pianobar shell-config

REPO ?= $(shell pwd)

xdg_data_dir = $(HOME)/.config
xdg_repo_dir = $(REPO)/.config

vim_dir = $(HOME)/.vim
vim_repo = $(REPO)/.vim
vim_targets = $(HOME)/.vim/autoload/pathogen.vim $(HOME)/.vimrc
vim_dirs = $(vim_dir) $(HOME)/.vim/autoload

shell_profile_dir = $(HOME)/.profile.d
shell_profile_repo = $(REPO)/.profile.d
shell_dirs = $(shell_profile_dir)
shell_targets = $(HOME)/.bashrc $(HOME)/.psrc $(HOME)/.profile $(HOME)/.profile.d/git-prompt.sh

i3_dir = $(HOME)/.i3
i3_repo = $(REPO)/.i3
i3_targets = $(i3_dir)/conky-i3bar $(i3_dir)/dex $(i3_dir)/libautostart.sh $(i3_dir)/conky-power $(i3_dir)/conky-wireless $(i3_dir)/conky-temp

pianobar_dir = $(xdg_data_dir)/pianobar
pianobar_repo = $(xdg_data_repo)/pianobar
pianobar_targets = $(pianobar_dir)/state $(pianobar_dir)/config

clean_targets = $(HOME)/.muttrc $(HOME)/.config/pianobar/config $(REPO)/.vim/vim-pathogen/autoload/pathogen.vim

TARGETS = $(HOME)/.playlists $(pianobar_targets) $(i3_targets) $(vim_targets) $(shell_targets)
DIRS = $(pianobar_dir) $(xdg_data_dir) $(i3_dir) $(vim_dirs) $(shell_dirs)
# linked not created .playlists, .vim, .i3/dex

all: install

install: $(DIRS) $(TARGETS) i3 pianobar vim shell-config

vim: $(vim_dirs) $(vim_targets)

i3: $(i3_targets)

pianobar: $(pianobar_dirs) $(pianobar_targets)

vim-config: $(vim_dir) $(vim_targets)

shell-config: $(shell_dirs) $(shell_targets)

clean:
	@rm -rf $(clean_targets)

dist-clean: clean
	git clean -dxf

$(pianobar_dir)/config: $(pianobar_dir)
	cp $(pianobar_repo)/config $@
	
$(HOME)/.vim/autoload/pathogen.vim: $(REPO)/.vim/vim-pathogen/autoload/pathogen.vim
	ln -sf $(REPO)/.vim/vim-pathogen/autoload/pathogen.vim $@

$(REPO)/.vim/vim-pathogen/autoload/pathogen.vim:
	git submodule update --init .vim/vim-pathogen

$(REPO)/.vim/autoload/pathogen.vim: $(REPO)/.vim/autoload $(REPO)/.vim/vim-pathogen/autoload/pathogen.vim
	ln -sf $(REPO)/.vim/vim-pathogen/autoload/pathogen.vim $@

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
