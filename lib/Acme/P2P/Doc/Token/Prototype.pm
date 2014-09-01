package Acme::P2P::Doc::Token::Prototype;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
    return " // prototype: $token\n"; 
}

1;
