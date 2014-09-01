package Acme::P2P::Doc::Token::DashedWord;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
    return qq{'$token'};
}

1;
