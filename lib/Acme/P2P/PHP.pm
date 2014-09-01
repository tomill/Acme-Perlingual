package Acme::P2P::PHP;
use strict;
use warnings;
use Encode;
use File::Temp;
use IO::File;

sub check {
    my ($self, $source) = @_;
    
    my $temp = File::Temp->new();
    $temp->print("<?php\n") if $source !~ /^<\?/m;
    $temp->print(encode_utf8 $source);
    
    my $out = qx(cat $temp | php -l 2>&1 1>/dev/null);
    return if $? == 0;
    return $out;
}

1;
