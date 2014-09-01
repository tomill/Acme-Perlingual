package Acme::P2P::Doc::Token::Separator;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
    return '// ' . $token;
}

1;
