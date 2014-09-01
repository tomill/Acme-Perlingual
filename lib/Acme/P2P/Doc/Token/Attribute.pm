package Acme::P2P::Doc::Token::Attribute;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
    my $prev = $elem->previous_sibling;
    if ($prev and
        $prev->class eq 'PPI::Token::Operator' and
        $prev->content eq ':') {
        $prev->{__php_skip} = 1;
    }
    
    return " // attribute: $token\n"; 
}

1;
