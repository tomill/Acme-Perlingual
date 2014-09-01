package Acme::P2P::Doc::Token::ArrayIndex;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
    $token =~ s/^\$#(.*)/count(\$$1)/;
    $token;
}

1;
