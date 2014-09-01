package Acme::P2P::Doc::Token::QuoteLike;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;

    # TODO fix lazy regex, should use quotemeta
    
    if ($elem->class eq 'PPI::Token::QuoteLike::Words') {
        $token =~ s/^qw.\s*|\s*.$//g;
        return qq{explode(' ', '$token')};
    }
    
    if ($elem->class eq 'PPI::Token::QuoteLike::Backtick') {
        return $token;
    }
    
    if ($elem->class eq 'PPI::Token::QuoteLike::Command') {
        $token =~ s/^qx.\s*|\s*.$//g;
        return qq{shell_exec('$token')};
    }
    
    if ($elem->class eq 'PPI::Token::QuoteLike::Regexp') {
        $token =~ s/^qr.\s*|\s*.$//g;
        $token =~ s{/}{\\/}g;
        return qq{"/$token/"};
    }

    if ($elem->class eq 'PPI::Token::QuoteLike::Readline') {
        return qq{readline($token)}
    }
    
    return $token; # give up
}

1;
