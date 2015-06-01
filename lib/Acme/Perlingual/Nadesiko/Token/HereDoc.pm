package Acme::Perlingual::Nadesiko::Token::HereDoc;
use strict;
use warnings;
use utf8;

sub convert {
    my ($self, $elem, $token) = @_;
    
    my @content = $elem->heredoc;

    return q{「} . join("", @content) . q{」};
}

1;
