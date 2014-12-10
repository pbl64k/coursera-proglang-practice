#!/usr/bin/perl

use warnings;
use strict;

my $x = `find . -name '*.md'`;

for my $fn (split /\n/m, $x)
{
    my $tgt = $fn;
    $tgt =~ s/\.md$/.pdf/;
    print 'Building '.$tgt."\n";
    system('pandoc -o '.$tgt.' '.$fn);
}

system('tar czvf pdfs.tar.gz `find . -name \'*.pdf\'`');

1;

