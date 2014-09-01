package Acme::P2P;
use 5.008001;
use strict;
use warnings;
our $VERSION = "0.01";
use Moo;

use Encode;
use Acme::P2P::Doc;
use Acme::P2P::Perl;
use Acme::P2P::PHP;

sub perl2php {
    my ($self, $input) = @_;
    
    my $output = Acme::P2P::Doc->new(source => $input)->to_php();
    
    my @errors = (
        Acme::P2P::Perl->check($input),
        Acme::P2P::PHP->check($output),
    );

    return {
        output => $output,
        errors => @errors ? \@errors : undef,
    };
}

1;
