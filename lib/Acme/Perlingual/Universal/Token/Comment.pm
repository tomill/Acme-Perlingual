package Acme::Perlingual::Universal::Token::Comment;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    $token =~ s!^[#]+!$self->{comment_prefix}!;
    $token;
}

1;
