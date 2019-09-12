GRISPAPP        ?= $(shell basename `find src -name "*.app.src"` .app.src)
REBAR           = rebar3
BASE_DIR        = $(shell pwd)
BUILD_DIR       = $(BASE_DIR)/_build
DEFAULT_BUILD_DIR       = $(BUILD_DIR)/default/lib
COOKIE          = MyCookie

all: compile

##
## Compilation targets
##

compile:
	$(REBAR) compile

clean: packageclean
	$(REBAR) clean

packageclean:
	rm -rdf $(DEFAULT_BUILD_DIR)/*/ebin/*

shell:
	$(REBAR) as test shell --sname $(GRISPAPP) --setcookie $(COOKIE) --apps $(GRISPAPP)

noappshell:
	$(REBAR) as test shell --sname $(GRISPAPP) --setcookie $(COOKIE) --apps $(GRISPAPP)

