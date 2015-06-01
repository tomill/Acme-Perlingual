package Acme::Perlingual::Nadesiko::Token::Quote;
use strict;
use warnings;
use utf8;

sub convert {
    my ($self, $elem, $token) = @_;
    $token =~ s/^qq?//;
    $token =~ s/^.|.$//g;
    return q{「} . $token . q{」};
}

1;
