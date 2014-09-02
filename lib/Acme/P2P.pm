package Acme::P2P;
use 5.010001;
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
__END__

=encoding utf-8

=head1 NAME

Acme::P2P - Converts perl code to php or something.

=head1 SYNOPSIS

    use Acme::P2P;
    my $php = Acme::P2P->new->perl2php($perl);

=head1 DESCRIPTION

Acme::P2P was born from :sushi: 現状確認会 (tech meeting)
L<http://www.zusaar.com/event/9467003> at VOYAGEGROUP.

Thanks L<PPI>, you are a great module.

=head1 FAQ

Q. is it a joke?

A. yes it is not completed but it works :P

Q. support python?

A. yes it can. it also starts "P".

Q. support javascript?

A. ya it is also one of "P"rogramming language.

=head1 SEE ALSO

L<http://p2p.koneta.org/> test page.

=head1 LICENSE

Copyright (C) Naoki Tomita.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=cut

