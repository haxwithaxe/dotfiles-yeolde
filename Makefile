
goals = all install load clean

targets = albert eeetop mega slacktop work yoshi

goal = $(firstword $(subst /, ,$(MAKECMDGOALS)))
subtarget = $(subst $(goal)/,,$(MAKECMDGOALS))

.PHONY: $(goal)/$(subtarget) help

$(goal)/$(subtarget):
	make -C $(subtarget) $(goal)

help:
	@echo "make <goal>/<target>"
	@echo "	goal: $(goals)"
	@echo "	target: $(targets)"

