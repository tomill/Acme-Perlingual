package Acme::Perlingual::Php53::Token::Symbol;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    return $token if $token =~ /^\$/;
    
    $token =~ s/^[%@&\*]/\$/; # WARN: no ref!
    $token;
}

1;
