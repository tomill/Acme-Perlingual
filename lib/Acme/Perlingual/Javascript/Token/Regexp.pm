package Acme::Perlingual::Javascript::Token::Regexp;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    my $curr = $elem;
    while (my $prev = $curr->previous_sibling) {
        if ($prev->class eq 'PPI::Token::Whitespace') {
            $prev->{__perlingual_skip} = 1;
        }
        elsif ($prev->class eq 'PPI::Token::Operator' and
            $prev->content eq '=~') {
            $prev->{__perlingual_content} = '.';
        }
        else {
            $prev->insert_before($prev->clone);
            $prev->insert_before(PPI::Token::Structure->new(' = '));
            last;
        }
        
        $curr = $prev;
    }
    
    if ($elem->class eq 'PPI::Token::Regexp::Match') {
        return qq{match($token)};
    } 
    if ($elem->class =~ /^PPI::Token::Regexp::(Substitute|Transliterate)/) {
        return sprintf(q{replace(/%s/, '%s')},
            $elem->get_match_string,
            $elem->get_substitute_string);
    } 
}

1;
