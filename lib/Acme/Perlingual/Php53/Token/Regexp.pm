package Acme::Perlingual::Php53::Token::Regexp;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    my @r;
    my $curr = $elem;
    while (my $prev = $curr->previous_sibling) {
        if ($prev->class eq 'PPI::Token::Whitespace') {
            $prev->{__perlingual_skip} = 1;
        }
        elsif ($prev->class eq 'PPI::Token::Operator' and
            $prev->content eq '=~') {
            $prev->{__perlingual_skip} = 1;
        }
        else {
            push @r, $prev->clone;
        }
        
        $prev->{__perlingual_skip} = 1;
        $curr = $prev;
    }
    
    for my $e (PPI::Token::Structure->new(')'), @r) {
        $elem->insert_after($e);
    }
    
    if ($elem->class eq 'PPI::Token::Regexp::Match') {
        return sprintf("preg_match('/%s/', ",
            $elem->get_match_string);
    } 
    if ($elem->class =~ /^PPI::Token::Regexp::(Substitute|Transliterate)/) {
        return sprintf("preg_replace('/%s/', '%s', ",
            $elem->get_match_string,
            $elem->get_substitute_string);
    } 
}

1;
