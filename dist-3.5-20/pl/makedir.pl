;# $Id: makedir.pl 1 2006-08-24 12:32:52Z rmanfredi $
;#
;#  Copyright (c) 1991-1997, 2004-2006, Raphael Manfredi
;#  
;#  You may redistribute only under the terms of the Artistic Licence,
;#  as specified in the README file that comes with the distribution.
;#  You may reuse parts of this distribution only within the terms of
;#  that same Artistic Licence; a copy of which may be found at the root
;#  of the source tree for dist 4.0.
;#
;# $Log: makedir.pl,v $
;# Revision 3.0  1993/08/18  12:10:54  ram
;# Baseline for dist 3.0 netwide release.
;#
;#
# Make directories for files
# E.g, for /usr/lib/perl/foo, it will check for all the
# directories /usr, /usr/lib, /usr/lib/perl and make
# them if they do not exist.
sub makedir {
    local($_) = shift;
    local($dir) = $_;
    if (!-d && $_ ne '') {
        # Make dirname first
        do makedir($_) if s|(.*)/.*|\1|;
		mkdir($dir, 0700) if ! -d $dir;
    }
}

