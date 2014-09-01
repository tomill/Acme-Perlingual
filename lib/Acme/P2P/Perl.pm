package Acme::P2P::Perl;
use strict;
use warnings;
use Encode;
use File::Temp;
use IO::File;

sub check {
    my ($self, $source) = @_;
    
    my $temp = File::Temp->new();
    $temp->print(encode_utf8 $source);
    
    my $out = qx(cat $temp | perl -c 2>&1);
    return if $? == 0;

    $out = 'Perl Parse error:  ' . $out;
    $out =~ s/- had compilation errors.\n//;
    $out;
}

1;
