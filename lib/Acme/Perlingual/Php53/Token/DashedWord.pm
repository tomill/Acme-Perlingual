package Acme::Perlingual::Php53::Token::DashedWord;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    return qq{'$token'};
}

1;
