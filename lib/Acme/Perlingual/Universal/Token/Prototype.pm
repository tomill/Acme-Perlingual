package Acme::Perlingual::Universal::Token::Prototype;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    return $self->comment_prefix . " prototype: $token\n"; 
}

1;
