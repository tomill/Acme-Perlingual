package Acme::P2P::Doc::Token::Magic;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
    return   q{$_PERL_MAGIC_VAR["$'"]} if $token eq q{$'};
    return qq{\$_PERL_MAGIC_VAR['$token']};
}

1;
