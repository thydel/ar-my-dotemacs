top:; @date

SHELL := bash

Makefile:;

pipe := BEGIN { m = "^\#pipe$$" }
pipe += $$1 ~ m && $$2 { $$1 = ""; p = $$0; printf "" | p; next }
pipe += !p { if (show) print }
pipe += $$0 ~ m { close(p); p = 0 }
pipe += p { print | p }

self := dotemacs

.stone: $(self)-role.yml; awk '$(pipe)' $<

. := $(if $(filter $(MAKECMDGOALS),main),$(or $(host),$(error host must be define)))

main = $(self)-play.yml -i $(host), $(AUSER) $(CHECK) $(DIFF) $(VERB)

main: .stone; $($@)

################

vartar := run diff verb

$(vartar):; @: '$($@)' $(eval $($@))

CHECK             := --check
run      := CHECK :=

DIFF              :=
diff     := DIFF  := --diff

VERB              :=
verb     := VERB  := -v

ifdef user
AUSER             := -u $(user)
endif

################

space :=
space +=

help.txt := \tmake help\n
help.txt += \tmake [$(subst $(space),|,$(vartar))] main [user=USER] host=HOST

help := echo -e "$(help.txt)"

help:; @$($@)

.PHONY: help
