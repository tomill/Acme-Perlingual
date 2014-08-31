package Acme::P2P::PHP;
use strict;
use warnings;
use Encode;
use File::Temp;

sub syntax_check {
    my ($self, $source) = @_;
    
    my $temp = File::Temp->new();
    
    print {$temp} "<?php\n";
    print {$temp} encode_utf8($source);
    
    my $filename = $temp->filename;
    my $out = qx(php -l $filename 2>&1);
    return if $? == 0;
    
    $out =~ s!$filename!<source>!gms;
    $out =~ s/Errors parsing <source>\n//;
    $out =~ s/^\s*\n//gm;
    chomp $out;

    return unless $out;
    return $out;
}

1;
