package Acme::Perlingual::Nadesiko::Token::Symbol;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    $token =~ s/^[\$%@&\*]//; # WARN: no ref support :/
    return $token;
}

1;
