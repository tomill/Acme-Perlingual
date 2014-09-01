package Acme::P2P::Doc::Token::Pod;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
    $token =~ s!^=head\d !!ms;
    $token =~ s!^=cut\s*!!ms;
    $token =~ s!^! * !gm;
    
    return "/**\n$token */\n";
}

1;
