package Acme::Perlingual::Javascript::Token::Symbol;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    return $token if $token =~ /^\$/;
    
    $token =~ s/^[%@&\*]/\$/; # WARN: no ref support :/
    $token;
}

1;
