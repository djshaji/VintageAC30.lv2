
BLUE = "\033[1;34m"
RED =  "\033[1;31m"
NONE = "\033[0m"

SUBDIR := VintageAC30

NOGOAL := mod install all

.PHONY: $(SUBDIR) libxputty  recurse

$(MAKECMDGOALS) recurse: $(SUBDIR)

clean:

check-and-reinit-submodules :
ifeq (,$(filter $(NOGOAL),$(MAKECMDGOALS)))
ifeq (,$(findstring clean,$(MAKECMDGOALS)))
	@if git submodule status 2>/dev/null | egrep -q '^[-]|^[+]' ; then \
		echo $(RED)"INFO: Need to reinitialize git submodules"$(NONE); \
		git submodule update --init; \
		echo $(BLUE)"Done"$(NONE); \
	else echo $(BLUE)"Submodule up to date"$(NONE); \
	fi
endif
endif

libxputty: check-and-reinit-submodules
ifeq (,$(filter $(NOGOAL),$(MAKECMDGOALS)))
	@exec $(MAKE) -j 1 -C $@ $(MAKECMDGOALS)
endif

$(SUBDIR): libxputty
	@exec $(MAKE) -j 1 -C $@ $(MAKECMDGOALS)

