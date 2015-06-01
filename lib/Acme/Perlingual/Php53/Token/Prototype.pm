package Acme::Perlingual::Php53::Token::Prototype;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    return " // prototype: $token\n"; 
}

1;
