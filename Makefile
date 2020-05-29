# Make with:
# 
# make CFENGINE_SOURCE=/path/to/cfengine/source CFENGINE_PREFIX=/path/to/cfengine/installdir
#
CC=gcc -std=gnu99

CFENGINE_SOURCE=/usr/local/src
CFENGINE_PREFIX=/var/cfengine
CFLAGS=-I$(CFENGINE_PREFIX)/include -I$(CFENGINE_SOURCE) -I$(CFENGINE_SOURCE)/libntech/libutils -I$(CFENGINE_SOURCE)/libpromises -I$(CFENGINE_SOURCE)/libcfnet

UNAME_S := $(shell uname -s)

# Solaris

ifeq ($(UNAME_S),SunOS)
	# Solaris
	LDFLAGS=-R$(CFENGINE_PREFIX)/lib -L$(CFENGINE_PREFIX)/lib
	#LDFLAGS=-L$(CFENGINE_PREFIX)/lib
	LDLIBS=-lpromises -lcrypto -lnsl -lsocket
	#LDLIBS=-Wl,-rpath,$(CFENGINE_PREFIX)/lib -lpromises -lcrypto
endif

# Linux

ifeq ($(UNAME_S),Linux)
	# Linux
	LDFLAGS=-L$(CFENGINE_PREFIX)/lib -L$(CFENGINE_SOURCE)/libpromises/.libs
	LDLIBS=-Wl,-rpath,$(CFENGINE_PREFIX)/lib -lpromises -lcrypto
endif

OBJECTS=cf-keycrypt

all: $(OBJECTS)

clean:
	rm -f cf-keycrypt
