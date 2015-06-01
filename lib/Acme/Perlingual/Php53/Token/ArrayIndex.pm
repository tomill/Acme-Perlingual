package Acme::Perlingual::Php53::Token::ArrayIndex;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    $token =~ s/^\$#(.*)/count(\$$1)/;
    $token;
}

1;
