package Acme::Perlingual::Universal::Token::Magic;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    return   q{$_PERL_MAGIC_VAR["$'"]} if $token eq q{$'};
    return qq{\$_PERL_MAGIC_VAR['$token']};
}

1;
