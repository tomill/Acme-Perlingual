package Acme::P2P::Doc::Token::Cast;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
    $elem->{__php_skip} = 1;
    return; # give up
}

1;
