package Acme::Perlingual::Php53::Token::Separator;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    return '// ' . $token;
}

1;
