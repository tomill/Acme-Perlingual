package Acme::Perlingual::Javascript::Token::Word;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    # TODO a lot
    my $prev  = $elem->previous_sibling;
    my $next  = $elem->next_sibling;
    my $prevs = $elem->sprevious_sibling;
    my $nexts = $elem->snext_sibling;
    my $parent = $elem->parent;

    return 'null' if $token eq 'undef';
    return '!' if $token eq 'not';
    return 'else if' if $token eq 'elsif';
    return 'continue' if $token eq 'next';
    return 'break' if $token eq 'last';
    
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
        return 'function';
    }

    
    if ($parent->class eq 'PPI::Statement::Expression') {
        return qq{'$token'};
    }
    
    # sigh....
    return $token;
}

1;
