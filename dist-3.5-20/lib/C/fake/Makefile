########################################################################
# Makefile generated from Makefile.SH on Fri  4 Jan 2008 18:37:45 CET

SHELL = /bin/sh
JMAKE = jmake
TOP = ../../..
CURRENT = lib/C/fake
DIR = lib/C/fake/
INSTALL = /usr/bin/install
INSTALLDIR = mkdir -p

########################################################################
# Parameters set by Configure -- edit config.sh if changes are needed

CTAGS = ctags
JCPPFLAGS = -W -Wall -Wformat=2 -I/usr/local/include
MV = /bin/mv
PRIVLIB = /pro/3gl/CPAN/lib/dist
RM = /bin/rm -f

########################################################################
# Jmake rules for building libraries, programs, scripts, and data files
# $X-Id: Jmake.rules 8 2006-08-25 22:27:18Z rmanfredi $

########################################################################
# Start of Jmakefile

# $X-Id: Jmakefile 9 2006-08-25 22:31:50Z rmanfredi $
#
#  Copyright (c) 1991-1997, 2004-2006, Raphael Manfredi
#
#  You may redistribute only under the terms of the Artistic Licence,
#  as specified in the README file that comes with the distribution.
#  You may reuse parts of this distribution only within the terms of
#  that same Artistic Licence; a copy of which may be found at the root
#  of the source tree for dist 4.0.
#
# $X-Log: Jmakefile,v $
# Revision 3.0.1.1  1994/01/24  13:43:44  ram
# patch16: created
#

FILES = dup2.C getopt.C rename.C scandir.C setsid.C

INSTALLFLAGS = -m 444

all::

install::
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for dir in $(PRIVLIB)/lib/C/fake; do \
		(set -x; test -d $$dir || $(INSTALLDIR) $$dir) || \
		exit 1; \
	done

local_install:: $(FILES)
	@case '${MFLAGS}' in *[i]*) set +e;; esac;		\
	(set -x; test -d $(INSTALL_PREFIX)$(PRIVLIB)/lib/C/fake || \
		$(INSTALLDIR) $(INSTALL_PREFIX)$(PRIVLIB)/lib/C/fake); \
	for i in $(FILES); do \
		(set -x; $(INSTALL) -c $(INSTALLFLAGS) \
			$$i $(INSTALL_PREFIX)$(PRIVLIB)/lib/C/fake) || exit 1;\
	done

local_deinstall::
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for i in $(FILES); do \
		(set -x; $(RM) $(INSTALL_PREFIX)$(PRIVLIB)/lib/C/fake/$$i); \
	done

########################################################################
# Common rules for all Makefiles -- do not edit

all::

clean: local_clean
realclean: local_realclean
clobber: local_clobber

local_clean::
	if test -f core; then $(RM) core; fi
	$(RM) *~ *.o

local_realclean:: local_clean

local_clobber:: local_realclean
	$(RM) Makefile config.sh

install:: local_install
install.man:: maybe_install.man
deinstall:: local_deinstall
deinstall.man:: maybe_deinstall.man

install.man-no:
deinstall.man-no:

maybe_install.man: install.man-no
maybe_deinstall.man: deinstall.man-no

Makefile.SH: Jmakefile
	-@if test -f $(TOP)/.package; then \
		if test -f Makefile.SH; then \
			echo "	$(RM) Makefile.SH~; $(MV) Makefile.SH Makefile.SH~"; \
			$(RM) Makefile.SH~; $(MV) Makefile.SH Makefile.SH~; \
		fi; \
		echo "	$(JMAKE) -DTOPDIR=$(TOP) -DCURDIR=$(CURRENT)" ; \
		$(JMAKE) -DTOPDIR=$(TOP) -DCURDIR=$(CURRENT) ; \
	else touch $@; fi

Makefile: Makefile.SH
	/bin/sh Makefile.SH

tags::
	$(CTAGS) -w *.[ch]
	$(CTAGS) -xw *.[ch] > tags

local_clobber::
	$(RM) tags

########################################################################
# Empty rules for directories with no sub-directories -- do not edit

local_install::
	@echo "install in $(CURRENT) done."

local_deinstall::
	@echo "deinstall in $(CURRENT) done."

local_install.man::
	@echo "install.man in $(CURRENT) done."

local_deinstall.man::
	@echo "deinstall.man in $(CURRENT) done."

Makefiles::

Makefiles.SH::

