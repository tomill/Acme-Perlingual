package Acme::Perlingual::Universal::Token::Label;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    $elem->{__perlingual_skip} = 1;
    return; # give up
}

1;
