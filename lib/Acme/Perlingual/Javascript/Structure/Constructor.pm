package Acme::Perlingual::Javascript::Structure::Constructor;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    return '[' if $token eq '[';
    return ']' if $token eq ']';
    return '{' if $token eq '{';
    return '}' if $token eq '}';
}

1;
