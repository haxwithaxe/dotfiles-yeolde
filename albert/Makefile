REPO ?= $(shell pwd)

trgt2src = $(subst $(HOME), $(REPO), $(1))
src2trgt = $(subst $(REPO), $(HOME), $(1))

.PHONY: all install load clean

targets = $(HOME)/.bashrc $(HOME)/.profile $(HOME)/.screenrc $(HOME)/.vimrc

sources = $(REPO)/.bashrc $(REPO)/.profile $(REPO)/.screenrc $(REPO)/.vimrc

all: install

install: $(targets)
	
load: $(sources) 

$(targets):
	trgt=$@
	src=$(call trgt2src, $@)
	ln -s $(src) $(trgt)
 
$(sources): 
	trgt=$@
	src=$(call src2trgt,$@)
	cp -r $(src) $(trgt)


