package Acme::Perlingual::Nadesiko::Token::Word;
use strict;
use warnings;
use utf8;

sub convert {
    my ($self, $elem, $token) = @_;
    
    my $prev  = $elem->previous_sibling;
    my $next  = $elem->next_sibling;
    my $prevs = $elem->sprevious_sibling;
    my $nexts = $elem->snext_sibling;
    my $parent = $elem->parent;
    
    return 'もし、' if $token eq 'if';
    return '違えば' if $token eq 'else';
    return '空' if $token eq 'undef';

    if ($token =~ /^(?:my|our)$/) {
        if ($next and $next->class eq 'PPI::Token::Whitespace') {
            $next->{__perlingual_skip} = 1;
        }
        $elem->{__perlingual_skip} = 1;
        return;
    }
    
    if ($token eq 'sub') {
        if ($nexts and
            $nexts->class eq 'PPI::Structure::Block') {
            return 'function()';
        }
        if ($nexts and
            $nexts->class eq 'PPI::Token::Word') {
            $nexts->{content} .= '()';
        }
        return '●';
    }

    if ($token eq 'return') {
        $nexts->insert_after(PPI::Token::Structure->new('で戻る'));
        $elem->{__perlingual_skip} = 1;
        return;
    }

    if ($token =~ /^(?:warn|print)$/) { 
        $nexts->insert_after(PPI::Token::Structure->new('を表示'));
        $elem->{__perlingual_skip} = 1;
        return;
    }

    if ($parent->class eq 'PPI::Statement::Expression') {
        return qq{「$token」};
    }
    
    # sigh....
    return $token;
}

1;
