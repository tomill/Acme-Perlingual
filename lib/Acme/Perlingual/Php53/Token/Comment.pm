package Acme::Perlingual::Php53::Token::Comment;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    $token =~ s!^[#]+!//!;
    $token;
}

1;
