package Acme::P2P::Doc::Structure::Constructor;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
    return 'array(' if $token eq '['; # sad that php is 5.3
    return ')'      if $token eq ']';
    return 'array(' if $token eq '{';
    return ')'      if $token eq '}';
}

1;
