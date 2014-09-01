package Acme::P2P::Doc::Token::Word;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
    # TODO a lot
    my $prev  = $elem->previous_sibling;
    my $next  = $elem->next_sibling;
    my $prevs = $elem->sprevious_sibling;
    my $nexts = $elem->snext_sibling;
    
    return 'null' if $token eq 'undef';
    return '!' if $token eq 'not';
    return 'elseif' if $token eq 'elsif';
    return 'continue' if $token eq 'next';
    return 'break' if $token eq 'last';
    
    if ($token =~ /^(?:my|our)$/) {
        if ($next and $next->class eq 'PPI::Token::Whitespace') {
            $next->{__php_skip} = 1;
        }
        $elem->{__php_skip} = 1;
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

    if ($token eq 'ref') {
        return 'is_array';          
    }
    if ($token =~ /^(?:sleep|sprintf|isset|unset)$/) { # sigh...
        return $token;
    }
    
    return $token;
}

1;