;# $Id: manifake.pl 1 2006-08-24 12:32:52Z rmanfredi $
;#
;#  Copyright (c) 1991-1997, 2004-2006, Raphael Manfredi
;#  
;#  You may redistribute only under the terms of the Artistic Licence,
;#  as specified in the README file that comes with the distribution.
;#  You may reuse parts of this distribution only within the terms of
;#  that same Artistic Licence; a copy of which may be found at the root
;#  of the source tree for dist 4.0.
;#
;# $Log: manifake.pl,v $
;# Revision 3.0  1993/08/18  12:10:55  ram
;# Baseline for dist 3.0 netwide release.
;#
;#
sub manifake {
    # make MANIFEST and MANIFEST.new say the same thing
    if (! -f $NEWMANI) {
        if (-f $MANI) {
            open(IN,$MANI) || die "Can't open $MANI";
            open(OUT,">$NEWMANI") || die "Can't create $NEWMANI";
            while (<IN>) {
                if (/---/) {
					# Everything until now was a header...
					close OUT;
					open(OUT,">$NEWMANI") ||
						die "Can't recreate $NEWMANI";
					next;
				}
                s/^\s*(\S+\s+)[0-9]*\s*(.*)/$1$2/;
				print OUT;
				print OUT "\n" unless /\n$/;	# If no description
            }
            close IN;
			close OUT;
        }
        else {
die "You need to make a $NEWMANI file, with names and descriptions.\n";
        }
    }
}

