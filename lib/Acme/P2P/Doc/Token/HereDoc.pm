package Acme::P2P::Doc::Token::HereDoc;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
    return join("",
        '<', $token, "\n",
        $elem->heredoc,
        $elem->terminator . ';',
    );
}

1;
