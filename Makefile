GRISPAPP        ?= $(shell basename `find src -name "*.app.src"` .app.src)
REBAR           = rebar3
BASE_DIR        = $(shell pwd)
BUILD_DIR       = $(BASE_DIR)/_build
CHECKOUTS_DIR       = $(BASE_DIR)/_checkouts
DEFAULT_BUILD_DIR       = $(BUILD_DIR)/default/lib
TEST_BUILD_DIR       = $(BUILD_DIR)/test/lib
COOKIE          = MyCookie

.PHONY: all compile clean packageclean checkoutsclean wipeout shell noappshell

all: compile

##
## Compilation targets
##

compile:
	$(REBAR) compile

##
## Cleaning targets
##

wipeout: packageclean checkoutsclean testclean clean
	@ echo Rebuilding VM \
	$(REBAR) update && \
	$(REBAR) unlock && \
	$(REBAR) upgrade && \
	$(REBAR) grisp build --clean true --configure true

clean: packageclean checkoutsclean
	$(REBAR) clean

packageclean:
	rm -rdf $(DEFAULT_BUILD_DIR)/*/ebin/*

checkoutsclean:
	rm -rdf $(CHECKOUTS_DIR)/*/ebin/*

testclean:
	rm -rdf $(TEST_BUILD_DIR)/*/ebin/*

build:  
	@ echo Rebuilding VM \
	$(REBAR) update && \
	$(REBAR) unlock && \
	$(REBAR) upgrade && \
	$(REBAR) grisp build --clean true --configure true

##
## Shell targets
##

shell:
	$(REBAR) as test shell --sname $(GRISPAPP) --setcookie $(COOKIE) --apps $(GRISPAPP)

noappshell:
	$(REBAR) as test shell --sname $(GRISPAPP) --setcookie $(COOKIE) --apps $(GRISPAPP)

