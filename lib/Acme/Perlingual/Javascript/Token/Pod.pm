package Acme::Perlingual::Javascript::Token::Pod;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    $token =~ s!^=head\d !!ms;
    $token =~ s!^=cut\s*!!ms;
    $token =~ s!^! * !gm;
    
    return "/**\n$token */\n";
}

1;
