package Acme::P2P::Doc::Token::Data;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
    $token =~ s!^!// !gm;
    $token;
}

1;
