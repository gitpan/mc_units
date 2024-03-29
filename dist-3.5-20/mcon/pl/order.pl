;# $Id: order.pl 1 2006-08-24 12:32:52Z rmanfredi $
;#
;#  Copyright (c) 1991-1997, 2004-2006, Raphael Manfredi
;#  
;#  You may redistribute only under the terms of the Artistic Licence,
;#  as specified in the README file that comes with the distribution.
;#  You may reuse parts of this distribution only within the terms of
;#  that same Artistic Licence; a copy of which may be found at the root
;#  of the source tree for dist 4.0.
;#
;# $Log: order.pl,v $
;# Revision 3.0  1993/08/18  12:10:28  ram
;# Baseline for dist 3.0 netwide release.
;#
;# 
;# The @cmdwanted array records the output of the makefile (pick commands only).
;# The shell commands are executed right away.
;#  @cmdwanted records the output of the make process (solving dependencies)
# Solve dependencies by saving the 'pick' command in @cmdwanted
sub solve_dependencies {
	local(%unitseen);			# Record already picked units (avoid duplicates)
	print "Determining the correct order for the units...\n" unless $opt_s;
	chdir('.MT') || die "Can't chdir to .MT: $!.\n";
	open(MAKE, "make -n |") || die "Can't run make";
	while (<MAKE>) {
		s|^\s+||;				# Some make print tabs before command
		print "\t$_" if $opt_v;
		if (/^pick/) {
			($pick,$cmd,$symbol,$unit) = split(' ');
			push(@cmdwanted,"$cmd $symbol $unit")
				unless $unitseen{"$cmd:$unit"}++;
		} elsif (/^cond/) {
			# Ignore conditional symbol request
		} else {
			chop;
			system;
		}
	}
	chdir($WD) || die "Can't chdir to $WD: $!.\n";
	close MAKE;
}

