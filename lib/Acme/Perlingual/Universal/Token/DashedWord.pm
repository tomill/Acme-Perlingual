package Acme::Perlingual::Universal::Token::DashedWord;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    return qq{'$token'};
}

1;
