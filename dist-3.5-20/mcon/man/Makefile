########################################################################
# Makefile generated from Makefile.SH on Fri  4 Jan 2008 18:37:45 CET

SHELL = /bin/sh
JMAKE = jmake
TOP = ../..
CURRENT = mcon/man
DIR = mcon/man/
INSTALL = /usr/bin/install
INSTALLDIR = mkdir -p

########################################################################
# Parameters set by Configure -- edit config.sh if changes are needed

CTAGS = ctags
JCPPFLAGS = -W -Wall -Wformat=2 -I/usr/local/include
L = 1
MANSRC = /usr/local/man/man1
MV = /bin/mv
RM = /bin/rm -f

########################################################################
# Automatically generated parameters -- do not edit

MANPAGE =  $(MPAGES)

########################################################################
# New suffixes and associated building rules -- edit with care

.SUFFIXES: .SH .1

.SH.1:
	/bin/sh $<

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
# Revision 3.0  1993/08/18  12:10:13  ram
# Baseline for dist 3.0 netwide release.
#

MPAGES = metaconfig.$(L) metalint.$(L) metaxref.$(L)

all:: $(MPAGES)

local_realclean::
	$(RM) $(MPAGES)

local_install.man::
	@case '${MFLAGS}' in *[i]*) set +e;; esac;		\
	(set -x; test -d $(INSTALL_PREFIX)$(MANSRC) || \
		$(INSTALLDIR) $(INSTALL_PREFIX)$(MANSRC)); \
	for file in $(MPAGES); do \
		(set -x; $(INSTALL) -c -m 444 $$file \
			$(INSTALL_PREFIX)$(MANSRC)) || exit 1; \
	done

local_deinstall.man::
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for file in $(MPAGES); do \
		(set -x; $(RM) $(INSTALL_PREFIX)$(MANSRC)/$$file); \
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

install.man-yes: local_install.man
install.man-no:
deinstall.man-yes: local_deinstall.man
deinstall.man-no:

maybe_install.man: install.man-yes
maybe_deinstall.man: deinstall.man-yes

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

