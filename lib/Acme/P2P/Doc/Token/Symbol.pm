package Acme::P2P::Doc::Token::Symbol;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
    return $token if $token =~ /^\$/;
    
    $token =~ s/^[%@&\*]/\$/; # WARN: no ref!
    $token;
}

1;
