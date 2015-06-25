REPO ?= $(shell pwd)

trgt2src = $(subst $(HOME), $(REPO), $(1))
src2trgt = $(subst $(REPO), $(HOME), $(1))

.PHONY: all install load clean

targets = $(HOME)/.bashrc \
	$(HOME)/.gtkrc-2.0 \
	$(HOME)/.irssi \
	$(HOME)/.profile \
	$(HOME)/.screenrc \
	$(HOME)/.xsessionrc

sources = $(REPO)/.bashrc \
	$(REPO)/.gtkrc-2.0 \
	$(REPO)/.irssi \
	$(REPO)/.profile \
	$(REPO)/.screenrc \
	$(REPO)/.xsessionrc

i3_targets = $(HOME)/.i3/config \
	$(HOME)/.i3/conky-i3bar \
	$(HOME)/.i3/conky-power.sh \
	$(HOME)/.i3/conkyrc \
	$(HOME)/.i3/conky-temp.sh \
	$(HOME)/.i3/conky-wireless.sh \
	$(HOME)/.i3/startup

i3_sources = $(REPO)/.i3/config \
	$(REPO)/.i3/conky-i3bar \
	$(REPO)/.i3/conky-power.sh \
	$(REPO)/.i3/conkyrc \
	$(REPO)/.i3/conky-temp.sh \
	$(REPO)/.i3/conky-wireless.sh \
	$(REPO)/.i3/startup

autostart_targets = $(HOME)/.config/autostart/dropbox.desktop \
	$(HOME)/.config/autostart/nm-applet.desktop \
	$(HOME)/.config/autostart/xfce4-power-manager.desktop

autostart_sources = $(REPO)/.config/autostart/dropbox.desktop \
	$(REPO)/.config/autostart/nm-applet.desktop \
	$(REPO)/.config/autostart/xfce4-power-manager.desktop

TARGET_DIRS = $(REPO)/.i3 $(HOME)/.config/autostart

all: install

install: $(targets) i3 autostart

load: $(sources) i3src autostartsrc

i3: $(HOME)/.i3 $(i3_targets)

i3src: $(REPO)/.i3 $(i3_sources)

autostart: $(HOME)/.config/autostart $(autostart_targets)

autostartsrc: $(REPO)/.config/autostart $(autostart_sources)

$(targets) $(i3_targets) $(autostart_targets):
	ln -s $(call trgt2src,$@) $@

$(TARGET_DIRS):
	mkdir -p $@

$(sources) $(i3_sources) $(autostart_sources):
	cp -r $(call src2trgt,$@) $@
