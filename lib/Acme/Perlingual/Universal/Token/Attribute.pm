package Acme::Perlingual::Universal::Token::Attribute;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    my $prev = $elem->previous_sibling;
    if ($prev and
        $prev->class eq 'PPI::Token::Operator' and
        $prev->content eq ':') {
        $prev->{__perlingual_skip} = 1;
    }
    
    return $self->comment_prefix . " attribute: $token\n"; 
}

1;
