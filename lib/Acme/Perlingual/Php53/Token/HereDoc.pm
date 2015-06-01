package Acme::Perlingual::Php53::Token::HereDoc;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    return join("",
        '<', $token, "\n",
        $elem->heredoc,
        $elem->terminator . ';',
    );
}

1;
