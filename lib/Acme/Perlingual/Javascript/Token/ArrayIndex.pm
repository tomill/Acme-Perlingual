package Acme::Perlingual::Javascript::Token::ArrayIndex;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    $token =~ s/^\$#(.*)/\$$1.length/;
    $token;
}

1;
