package Acme::Perlingual::Universal::Token::Separator;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    return $self->comment_prefix . ' ' . $token;
}

1;
