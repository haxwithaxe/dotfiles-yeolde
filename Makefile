
goals = all install load clean

targets = common mega ckoepke lenny lucky unlucky

goal = $(firstword $(subst /, ,$(MAKECMDGOALS)))
subtarget = $(subst $(goal)/,,$(MAKECMDGOALS))

.PHONY: help $(targets) update update-submodules $(goal)/$(subtarget) 

GIT_UPDATE = git submodule foreach git pull origin master
GIT_SYNC = git submodule update --recursive --remote --merge

help:
	@echo "make <goal>/<target>"
	@echo "	goal: $(goals)"
	@echo "	target: $(targets)"
	@echo "make test/<goal>/<target>"
	@echo "make test/clean"

update: PULL update-submodules

PULL:
	git pull --rebase

update-submodules:
	$(GIT_UPDATE)
	$(MAKE) -C common MAKE_SUBMODULES

sync-submodules:
	$(GIT_SYNC)
	$(MAKE) -C common MAKE_SUBMODULES

make/%: update/%
	$(MAKE) -C $*

update/%:
	$(GIT_UPDATE) $*

on-commit:
	;$(MAKE) -C $(shell hostname) on-commit
	$(MAKE) -C common on-commit

dist-clean: clean
	git clean -dxf

$(targets):
	$(MAKE) -C $@

$(goal)/$(subtarget):
	$(MAKE) -C $(goal) $(subtarget)

test/clean:
	rm -rf /tmp/test-home

test/$(subtarget):
	mkdir -p /tmp/test-home	
	$(MAKE) $(subtarget) HOME=/tmp/test-home

