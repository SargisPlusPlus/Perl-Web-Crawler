!/usr/bin/perl -w

# A simple web crawler which uses LWP::Simple

use strict;
use LWP::Simple;

#perldoc LWP::Simple for more info

my $url = shift || die "Please Provide an initial source URL";
my $max = 10;

my $html = get($url);

my @urls;
while ($html =~ s/(http:\/\/\S+)[">]//) {
	push @urls, $1;
}

mkdir web, 0755;
open(URLMAP, "web/url.map") || die "can't open web/url.map\n";
my $count = 0;

for (my $i=0; $i<$max; $i++){
	my $source = $urls[int(rand($#urls+1))];
	getstore($source, "web.$count.html");
	print URLMAP "$count\t$source\n";
	print STDERR "Getting $count: $source\n";
	$count++;
}

close URLMAP;