case $CONFIG in
'')
	if test -f config.sh; then TOP=.;
	elif test -f ../config.sh; then TOP=..;
	elif test -f ../../config.sh; then TOP=../..;
	elif test -f ../../../config.sh; then TOP=../../..;
	elif test -f ../../../../config.sh; then TOP=../../../..;
	else
		echo "Can't find config.sh."; exit 1
	fi
	. $TOP/config.sh
	;;
esac
case "$0" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
echo "Extracting jmake/jmkmf (with variable substitutions)"
$spitshell >jmkmf <<!GROK!THIS!
$startsh
!GROK!THIS!
$spitshell >>jmkmf <<'!NO!SUBS!'
# @(#) Generates a Makefile from a Jmakefile

# $Id: jmkmf.SH 1 2006-08-24 12:32:52Z rmanfredi $
#
#  Copyright (c) 1991-1997, 2004-2006, Raphael Manfredi
#  
#  You may redistribute only under the terms of the Artistic Licence,
#  as specified in the README file that comes with the distribution.
#  You may reuse parts of this distribution only within the terms of
#  that same Artistic Licence; a copy of which may be found at the root
#  of the source tree for dist 4.0.
#
# $Log: jmkmf.SH,v $
# Revision 3.0.1.2  2004/08/21 23:18:13  ram
# patch71: automatically figures the top dir and the current dir
# patch71: don't run Makefile.SH if the jmake call failed
#
# Revision 3.0.1.1  1993/08/19  06:42:14  ram
# patch1: leading config.sh searching was not aborting properly
#
# Revision 3.0  1993/08/18  12:04:19  ram
# Baseline for dist 3.0 netwide release.
#

usage="usage:  $0 [top_of_sources_pathname [current_directory]]"

curdir=

case $# in 
    0)
		if test -f .package; then topdir=.;
		elif test -f ../.package; then topdir=..;
		elif test -f ../../.package; then topdir=../..;
		elif test -f ../../../.package; then topdir=../../..;
		elif test -f ../../../../.package; then topdir=../../../..;
		else
			echo "$0: WARNING: can't determine top package directory" >&2
		fi
		;;
    1) topdir=$1 ;;
    2) topdir=$1  curdir=$2 ;;
    *) echo "$usage" 1>&2; exit 1 ;;
esac

case "$topdir" in
    -*) echo "$usage" 1>&2; exit 1 ;;
esac

case "$curdir" in
'')
	here=`pwd`
	top=`cd $topdir; pwd`
	curdir=`perl -e \
		'print substr($ARGV[0], length($ARGV[1])+1), "\n";' $here $top`
	case "$curdir" in
	'') curdir=.;;
	esac
	;;
esac

if test -f Jmakefile; then
	: ok
else
	echo "$0: no Jmakefile found in current directory" >&2
	exit 1
fi

if test -f Makefile.SH; then 
    echo mv Makefile.SH Makefile.SH~
    mv Makefile.SH Makefile.SH~
fi

args="-DTOPDIR=$topdir -DCURDIR=$curdir"

echo jmake $args
if jmake $args; then
	echo sh Makefile.SH
	sh Makefile.SH
else
	echo "jmake failed, aborting" >&2
	exit 1
fi
!NO!SUBS!
chmod 755 jmkmf
$eunicefix jmkmf
