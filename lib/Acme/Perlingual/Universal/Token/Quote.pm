package Acme::Perlingual::Universal::Token::Quote;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    if ($elem->class eq 'PPI::Token::Quote::Literal') {
        $token =~ s/^q.\s*|\s*.$//g;
        return qq{'$token'};
    }
    
    if ($elem->class eq 'PPI::Token::Quote::Interpolate') {
        $token =~ s/^qq.\s*|\s*.$//g;
        return qq{"$token"};
    }
    
    return $token; # Single, Double
}

1;
