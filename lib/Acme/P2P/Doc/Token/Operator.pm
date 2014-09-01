package Acme::P2P::Doc::Token::Operator;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
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
