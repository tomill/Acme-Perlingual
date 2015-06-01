package Acme::Perlingual::Lang;
use strict;
use warnings;
use Module::Runtime qw/require_module/;
use PPI::Document;
use Try::Tiny;
use Moo::Role;

=head1 NAME

Acme::Perlingual::Lang - Role module for Acme::Perlingual::XXX

=cut

has namespace => (is => 'rw', default => sub { ref(shift) });
has source => (is => 'rw');
has doc => (is => 'rw');
has options => (is => 'rw', default => sub { +{} });
has lines => (is => 'rw', default => sub { +[] });

sub BUILD {
    my ($self) = @_;
    $self->convert;
}

sub prepare { }
sub finalize { }

sub as_string {
    my ($self) = @_;
    join "", @{ $self->lines };
}

sub convert {
    my ($self) = @_;
    
    $self->prepare;
    
    my $doc = PPI::Document->new(\ $self->source);
    $self->doc($doc);
    
    $self->walk($doc, sub {
        my ($self, $elem, $token) = @_;
        if ($elem->isa('PPI::Structure')) {
            $elem->{__perlingual_start}  = $self->convert_token($elem, $elem->start);
            $elem->{__perlingual_finish} = $self->convert_token($elem, $elem->finish);
        }
        elsif ($elem->isa('PPI::Token')) {
            $elem->{__perlingual_content} = $self->convert_token($elem, $elem->content);
        }
    });
    
    $self->walk($doc, sub {
        my ($self, $elem, $token) = @_;
        return if $elem->{__perlingual_skip};
        return unless defined $token;
        push @{ $self->lines }, $token;
    });

    $self->finalize;
}

sub walk {
    my ($self, $elem, $callback) = @_;
    
    if ($elem->isa('PPI::Structure')) {
        $callback->($self, $elem, $elem->{__perlingual_start} // $elem->start);
    }

    if ($elem->isa('PPI::Node') and not $elem->{__perlingual_skip}) {
        for my $child_node ($elem->children) {
            $self->walk($child_node, $callback);
        }
    }
    elsif ($elem->isa('PPI::Token')) {
        $callback->($self, $elem, $elem->{__perlingual_content} // $elem->content);
    }
    
    if ($elem->isa('PPI::Structure')) {
        $callback->($self, $elem, $elem->{__perlingual_finish} // $elem->finish);
    }
}

sub convert_token {
    my ($self, $elem, $token) = @_;
    return unless $token;
    
    my $class = $self->get_converter($elem);
    
    if ($class) {
        return $class->convert($elem, $token);
    } else {
        return $token; # give up (or same as perl)
    }
}

sub get_converter {
    my ($self, $elem) = @_;
    my $class = $elem->class;
       $class =~ s/^PPI:://;
       $class = $self->namespace . '::' . $class;
    
    try {
        require_module($class);
    } catch {
        # one challenge more (try to get parent namespace)
        try {
            $class =~ s/::[^:]+$//;
            require_module($class);
        };
    };
    
    if (try { $class->can('convert') }) {
        return $class;
    }
}

1;
