#!/usr/bin/perl

use warnings;
use strict;

my $x = `find . -name '*.md'`;

for my $fn (split /\n/m, $x)
{
    my $tgt = $fn;
    $tgt =~ s/\.md$/.pdf/;
    print 'Building '.$tgt."\n";
    system('sed '."'".'s/\$\$/$/g'."'".' '.$fn.' | pandoc -o '.$tgt);
}

system('tar czvf pdfs.tar.gz `find . -name \'*.pdf\'`');

1;

