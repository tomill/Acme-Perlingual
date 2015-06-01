package Acme::Perlingual::Php53::Token::Data;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    $token =~ s!^!// !gm;
    $token;
}

1;
