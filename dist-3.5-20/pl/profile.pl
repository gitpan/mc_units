;# $Id: profile.pl 1 2006-08-24 12:32:52Z rmanfredi $
;#
;#  Copyright (c) 1991-1997, 2004-2006, Raphael Manfredi
;#  
;#  You may redistribute only under the terms of the Artistic Licence,
;#  as specified in the README file that comes with the distribution.
;#  You may reuse parts of this distribution only within the terms of
;#  that same Artistic Licence; a copy of which may be found at the root
;#  of the source tree for dist 4.0.
;#
;# $Log: profile.pl,v $
;# Revision 3.0.1.1  1994/01/24  14:33:53  ram
;# patch16: created
;#
;#
;# Dist profile management (works like MH and its ~/.mh_profile):
;# - Profile name is held in the environment variable DIST. If not defined,
;#   use ~/.dist_profile by default.
;# - Each line in the profile not starting with a '#' (comment line) should
;#   have the following format:
;#     progname: additional command line options
;# The profile is parsed once when the command is launched and profile
;# options are added at the beginning of the @ARGV array.
;#
;# Per-program configuration values may be also be added. For instance,
;# program foo may pay attention to a profile component 'bar', which may be
;# set via:
;#     foo-bar: value
;# i.e. the program name is followed by a '-', followed by the profile
;# component.
;#
;# Uses &tilda_expand to perform ~name substitution.
;# Requires shellwords.pl to properly quote shell words (perl library).
;#
# Set up profile components into %Profile, add any profile-supplied options
# into @ARGV and return the command invocation name.
sub profile {
	local($profile) = &tilda_expand($ENV{'DIST'} || '~/.dist_profile');
	local($me) = $0;		# Command name
	$me =~ s|.*/(.*)|$1|;	# Keep only base name
	return $me unless -s $profile;
	local(*PROFILE);		# Local file descriptor
	local($options) = '';	# Options we get back from profile
	unless (open(PROFILE, $profile)) {
		warn "$me: cannot open $profile: $!\n";
		return;
	}
	local($_);
	local($component);
	while (<PROFILE>) {
		next if /^\s*#/;	# Skip comments
		next unless /^$me/o;
		if (s/^$me://o) {	# progname: options
			chop;
			$options .= $_;	# Merge options if more than one line
		}
		elsif (s/^$me-([^:]+)://o) {	# progname-component: value
			$component = $1;
			chop;
			s/^\s+//;		# Trim leading and trailing spaces
			s/\s+$//;
			$Profile{$component} = $_;
		}
	}
	close PROFILE;
	return unless $options;
	require 'shellwords.pl';
	local(@opts);
	eval '@opts = &shellwords($options)';	# Protect against mismatched quotes
	unshift(@ARGV, @opts);
	return $me;				# Return our invocation name
}

