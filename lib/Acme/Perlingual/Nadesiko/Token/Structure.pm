package Acme::Perlingual::Nadesiko::Token::Structure;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    return "" if $token eq ';';
    return $token;
}

1;
