package Acme::P2P::Doc::Token::Comment;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
    $token =~ s!^[#]+!//!;
    $token;
}

1;
