
goals = all install load clean

targets = common eeetop mega ckoepke lenny yoshi

goal = $(firstword $(subst /, ,$(MAKECMDGOALS)))
subtarget = $(subst $(goal)/,,$(MAKECMDGOALS))

.PHONY: $(goal)/$(subtarget) help

%:
	make -C $(subtarget) $(goal)

help:
	@echo "make <goal>/<target>"
	@echo "	goal: $(goals)"
	@echo "	target: $(targets)"

