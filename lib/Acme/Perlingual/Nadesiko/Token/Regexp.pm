package Acme::Perlingual::Nadesiko::Token::Regexp;
use strict;
use warnings;
use utf8;

sub convert {
    my ($self, $elem, $token) = @_;
    
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
            last;
        }
        
        $curr = $prev;
    }
    
    if ($elem->class eq 'PPI::Token::Regexp::Match') {
        return qq{を「${token}」で正規表現マッチ};
    } 
    if ($elem->class =~ /^PPI::Token::Regexp::(Substitute|Transliterate)/) {
        return sprintf(q{の「%s」を「%s」へ正規表現置換},
            $elem->get_match_string,
            $elem->get_substitute_string);
    } 
}

1;
