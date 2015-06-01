package Acme::Perlingual::Nadesiko::Token::QuoteLike;
use strict;
use warnings;
use utf8;

sub convert {
    my ($self, $elem, $token) = @_;

    # TODO fix lazy regex, should use quotemeta
    
    if ($elem->class eq 'PPI::Token::QuoteLike::Words') {
        $token =~ s/^qw.\s*|\s*.$//g;
        return q{「} . join(',', split / /, $token) . q{」};
    }
    
    if ($elem->class eq 'PPI::Token::QuoteLike::Regexp') {
        $token =~ s/^qr.\s*|\s*.$//g;
        $token =~ s{/}{\\/}g;
        return qq{「m/$token/」};
    }

    return $token; # give up
}

1;
