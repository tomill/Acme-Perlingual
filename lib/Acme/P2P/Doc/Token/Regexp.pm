package Acme::P2P::Doc::Token::Regexp;
use strict;
use warnings;

sub to_php {
    my ($self, $elem, $token) = @_;
    
    my $target = "";
    my $curr = $elem;
    while (my $prev = $curr->previous_sibling) {
        if ($prev->class eq 'PPI::Token::Whitespace') {
            $prev->{__php_skip} = 1;
        }
        elsif ($prev->class eq 'PPI::Token::Operator' and
            $prev->content eq '=~') {
            $prev->{__php_skip} = 1;
        }
        elsif ($prev->class =~ /^PPI::Token::(Symbol|Word)/) {
            $prev->{__php_skip} = 1;
            $target = $prev->content;
            last;
        }
        $curr = $prev;
    }

    if ($elem->class eq 'PPI::Token::Regexp::Match') {
        return sprintf("preg_match('%s', %s)",
            $elem->get_match_string,
            $target);
    } 
    if ($elem->class =~ /^PPI::Token::Regexp::(Substitute|Transliterate)/) {
        return sprintf("preg_replace('%s', '%s', %s)",
            $elem->get_match_string,
            $elem->get_substitute_string,
            $target);
    } 
}

1;
