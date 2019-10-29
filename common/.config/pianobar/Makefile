.SHELL: /bin/bash

.PHONY: all install load clean dist-clean UPDATE_SUBMODULES MAKE_SUBMODULES
.DEFAULT: all

REPO ?= $(shell pwd)

DIR = $(xdg_data_dir)/pianobar
TARGETS = $(DIR)/state \
		  $(DIR)/config \
		  $(DIR)/pianobar-ctl \
		  $(DIR)/ctl

$(DIR)/Makefile::

all: install
	echo "there's no place like $(HOME)"

install: $(DIR) $(TARGETS)

clean:
	rm $(DIR)/config

dist-clean:
	rm $(TARGETS)
	rm -r $(DIR)

# Copy the config so that is doesn't contaminate the repo
$(DIR)/config: $(DIR)
	cp $(REPO)/config $@

$(DIR)/ctl: $(DIR)
	@test -e "$@" || mkfifo $@

$(DIR)/%: $(DIR) $(REPO)/%
	ln -sf $(REPO)/$* $@

$(DIR):
	mkdir -p $(DIR)

