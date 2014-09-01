package Acme::P2P::Doc::Structure::Subscript;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
    my $prev = $elem->previous_sibling;
    if ($prev and
        $prev->class eq 'PPI::Token::Operator' and
        $prev->content eq '->') {
        $prev->{__php_skip} = 1;
    }
    
    return '[' if $token eq '{';
    return ']' if $token eq '}';
    return '[' if $token eq '[';
    return ']' if $token eq ']';
}

1;
