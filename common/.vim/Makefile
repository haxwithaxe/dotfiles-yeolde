.SHELL: /bin/bash

.PHONY: all install base submodules update clean dist-clean

REPO ?= $(shell pwd)

INSTALL_DIR = $(HOME)/.vim
# INSTALL_DIR is linked no need to have any targets inside it besides those
#   required for pathogen
TARGETS = $(HOME)/.vim/autoload/pathogen.vim
NOOP_TARGETS = $(HOME)/.vim/bundle/jedi-vim \
	$(HOME)/.vim/bundle/supertab \
	$(HOME)/.vim/bundle/syntastic \
	$(HOME)/.vim/bundle/vim-indent-guides \
	$(HOME)/.vim/bundle/vim-surround \
	$(HOME)/.vim/vim-pathogen

all: install

base: install

install: $(INSTALL_DIR) $(TARGETS)

update: update/bundle/jedi-vim  update/bundle/supertab  update/bundle/syntastic  update/bundle/vim-indent-guides  update/bundle/vim-surround update/vim-pathogen

update/%:
	git submodule update --init --recursive --remote --merge ./$*

clean:
	rm $(INSTALL_DIR)/vim-pathogen/autoload/pathogen.vim
	rm $(REPO)/autoload/pathogen.vim

clean/%:
	rm $(INSTALL_DIR)/$*

dist-clean: clean
	rm $(INSTALL_DIR)

$(INSTALL_DIR):
	ln -sf $(REPO) $@

$(REPO)/vim-pathogen/autoload/pathogen.vim: update/vim-pathogen

$(REPO)/autoload/pathogen.vim: $(REPO)/autoload $(REPO)/vim-pathogen/autoload/pathogen.vim
	ln -sf $(REPO)/vim-pathogen/autoload/pathogen.vim $@

$(INSTALL_DIR)/autoload/pathogen.vim: $(INSTALL_DIR) $(REPO)/autoload/pathogen.vim
	ln -sf $(REPO)/vim-pathogen/autoload/pathogen.vim $@

$(NOOP_TARGETS)::

$(INSTALL_DIR)/%: $(INSTALL_DIR)
	@echo installing \"$@\"
	ln -sf $(REPO)/$* $@

