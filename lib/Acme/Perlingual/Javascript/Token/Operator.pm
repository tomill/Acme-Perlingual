package Acme::Perlingual::Javascript::Token::Operator;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
        
    if ($token eq '->' or
        $token eq '=>') {
        if ($elem->previous_sibling->class eq 'PPI::Token::Whitespace') {
            $elem->previous_sibling->{__perlingual_skip} = 1;
        }
        
        return '.'  if $token eq '->';
        return ':'  if $token eq '=>';
    }
    
    return '<'  if $token eq 'lt';
    return '<=' if $token eq 'le';
    return '>'  if $token eq 'gt';
    return '>=' if $token eq 'ge';
    return '==' if $token eq 'eq';
    return 'ne' if $token eq 'ne';
    return '!'  if $token eq 'not';
    return $token; # give up
}

1;
