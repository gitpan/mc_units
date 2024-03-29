;# $Id: copyright.pl 1 2006-08-24 12:32:52Z rmanfredi $
;#
;#  Copyright (c) 1991-1997, 2004-2006, Raphael Manfredi
;#  
;#  You may redistribute only under the terms of the Artistic Licence,
;#  as specified in the README file that comes with the distribution.
;#  You may reuse parts of this distribution only within the terms of
;#  that same Artistic Licence; a copy of which may be found at the root
;#  of the source tree for dist 4.0.
;#
;# $Log: copyright.pl,v $
;# Revision 3.0  1993/08/18  12:10:51  ram
;# Baseline for dist 3.0 netwide release.
;#
;#
;# Copyright expansion. The @COPYRIGHT@ symbol is expanded the first time
;# it is seen in a file, and before the $Log RCS marker is reached. The
;# automaton needs to be reset for each file.
;#
package copyright;

# Read in copyright file
sub init {
	local($file) = @_;		# Copyright file
	undef @copyright;
	open(COPYRIGHT, $file) || die "Can't open $file: $!\n";
	chop(@copyright = <COPYRIGHT>);
	close COPYRIGHT;
}

# Reset the automaton for a new file.
sub reset {
	$copyright_seen = @copyright ? 0 : 1;
	$marker_seen = 0;
}

# Filter file, line by line, and expand the copyright string. The @COPYRIGHT@
# symbol may be preceded by some random comment. A leader can be defined and
# will be pre-pended to all the input lines.
sub filter {
	local($line, $leader) = @_;		# Leader is optional
	return $leader . $line if $copyright_seen || $marker_seen;
	$marker_seen = 1 if $line =~ /\$Log[:\$]/;
	$copyright_seen = 1 if $line =~ /\@COPYRIGHT\@/;
	return $leader . $line unless $copyright_seen;
	local($comment, $trailer) = $line =~ /^(.*)\@COPYRIGHT\@\s*(.*)/;
	$comment = $leader . $comment;
	$comment . join("\n$comment", @copyright) . "\n";
}

# Filter output of $cmd redirected into $file by expanding copyright, if any.
sub expand {
	local($cmd, $file) = @_;
	if (@copyright) {
		open(CMD,"$cmd|") || die "Can't start '$cmd': $!\n";
		open(OUT, ">$file") || die "Can't create $file: $!\n";
		&reset;
		local($_);
		while (<CMD>) {
			print OUT &filter($_);
		}
		close OUT;
		close CMD;
	} else {
		system "$cmd > $file";
		die "Command '$cmd' failed!" if $?;
	}
}

package main;

