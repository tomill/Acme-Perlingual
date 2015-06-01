package Acme::Perlingual::Universal::Token::Data;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    $token =~ s!^!$self->{comment_prefix} !gm;
    $token;
}

1;
