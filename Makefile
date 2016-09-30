
goals = all install load clean

targets = common mega ckoepke lenny lucky

goal = $(firstword $(subst /, ,$(MAKECMDGOALS)))
subtarget = $(subst $(goal)/,,$(MAKECMDGOALS))

.PHONY: help $(targets) update update-submodules $(goal)/$(subtarget) 

GIT_UPDATE = git submodule update --recursive --remote --merge

help:
	@echo "make <goal>/<target>"
	@echo "	goal: $(goals)"
	@echo "	target: $(targets)"


update: PULL update-submodules

PULL:
	git pull --rebase

update-submodules:
	$(GIT_UPDATE)
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



