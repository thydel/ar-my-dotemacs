top:; @date

Makefile:;

pipe := BEGIN { m = "^\#pipe$$" }
pipe += $$1 ~ m && $$2 { $$1 = ""; p = $$0; printf "" | p; next }
pipe += !p { if (show) print }
pipe += $$0 ~ m { close(p); p = 0 }
pipe += p { print | p }

self := dotemacs

.stone: $(self)-role.yml; awk '$(pipe)' $<

. := $(or $(host),$(error host must be define))

main = ansible-playbook -i $(host), $(self)-play.yml $(AUSER) $(CHECK) $(DIFF) $(VERB)

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
