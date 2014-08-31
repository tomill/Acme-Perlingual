package Acme::P2P;
use 5.008001;
use strict;
use warnings;
our $VERSION = "0.01";

use Moo;

use Acme::P2P::Perl;
use Acme::P2P::PHP;

sub perl2php {
    my ($self, $input) = @_;
    
    my $output = Acme::P2P::Perl->to_php($input);
    
    my @errors;
    if (my $e = Acme::P2P::Perl->syntax_check($input)) {
        push @errors, $e;
    }
    if (my $e = Acme::P2P::PHP->syntax_check($output)) {
        push @errors, $e;
    }

    return {
        output => $output,
        error  => @errors ? join("\n", @errors) : undef,
    };
}

1;
