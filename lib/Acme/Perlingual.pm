package Acme::Perlingual;
use 5.010001;
use strict;
use warnings;
our $VERSION = "0.02";
use Module::Runtime qw/require_module/;
use Try::Tiny;
use Moo;

has source => (is => 'rw');

sub convert {
    my ($self, $to, $options) = @_;
    my $module = __PACKAGE__ . '::' . ucfirst(lc $to);

    my $lang = try {
        require_module($module);
        $module->new(source => $self->source, options => $options || {});
    } catch {
        my $err = shift;
        die "Sorry I don't know the language: $to\n" . $err;
    };
    
    return $lang;
}

1;
__END__

=encoding utf-8

=head1 NAME

Acme::Perlingual - Converts perl code to php or something.

=head1 SYNOPSIS

    use Acme::Perlingual;
    my $lang = Acme::Perlingual->new(source => "some perl code")->convert('php');
    print $lang->as_string;

=head1 DESCRIPTION

Acme::P2P was born from :sushi: 現状確認会 (tech meeting)
L<http://www.zusaar.com/event/9467003> at VOYAGEGROUP.

Thanks L<PPI>, you are a great module.

=head1 LICENSE

Copyright (C) Naoki Tomita.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=cut

