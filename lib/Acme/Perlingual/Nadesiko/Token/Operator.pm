package Acme::Perlingual::Nadesiko::Token::Operator;
use strict;
use warnings;
use utf8;

sub convert {
    my ($self, $elem, $token) = @_;
    
    my $op;
    $op = '未満' if $token eq 'lt' or $token eq '<';
    $op = '以下' if $token eq 'le' or $token eq '<=';
    $op = '超' if $token eq 'gt' or $token eq '>';
    $op = '以下' if $token eq 'ge' or $token eq '>=';
    $op = 'ならば' if $token eq 'eq' or $token eq '==';
    $op = 'でなければ' if $token eq 'ne' or $token eq '!=';
    
    return $token unless $op;
    
    my $curr = $elem;
    while (my $next = $curr->next_sibling) {
        if ($next->class eq 'PPI::Token::Whitespace') {
            $next->{__perlingual_skip} = 1;
        }
        else {
            $next->insert_after(PPI::Token::Structure->new($op));
            last;
        }
        
        $curr = $next;
    }

    return 'が';
}

1;
