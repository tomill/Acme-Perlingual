package Acme::Perlingual::Javascript::Token::HereDoc;
use strict;
use warnings;

sub convert {
    my ($self, $elem, $token) = @_;
    
    my @content = $elem->heredoc;
    for my $line (@content) {
        $line =~ s/(\r?\n)$/\\$1/;
    }

    return q{"} . join("", @content) . q{"};
}

1;
