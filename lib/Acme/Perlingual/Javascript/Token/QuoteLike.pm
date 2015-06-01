package Acme::Perlingual::Javascript::Token::QuoteLike;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;

    # TODO fix lazy regex, should use quotemeta
    
    if ($elem->class eq 'PPI::Token::QuoteLike::Words') {
        $token =~ s/^qw.\s*|\s*.$//g;
        return qq{'$token'.split(/ /)};
    }
    
    if ($elem->class eq 'PPI::Token::QuoteLike::Backtick') {
        return $token;
    }
    
    if ($elem->class eq 'PPI::Token::QuoteLike::Regexp') {
        $token =~ s/^qr.\s*|\s*.$//g;
        $token =~ s{/}{\\/}g;
        return qq{/$token/};
    }

    return $token; # give up
}

1;
