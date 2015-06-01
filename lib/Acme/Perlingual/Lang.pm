package Acme::Perlingual::Lang;
use strict;
use warnings;
use Moo::Role;
use PPI::Document;

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
    join "\n", @{ $self->lines };
}

sub convert {
    my ($self) = @_;
    
    $self->prepare;
    
    my $doc = PPI::Document->new(\ $self->source);
    $self->doc($doc);
    
    $self->walk($doc, sub {
        my ($self, $elem, $token) = @_;
        if ($elem->isa('PPI::Structure')) {
            $elem->{__perlingual_start}  = $self->token($elem, $elem->start);
            $elem->{__perlingual_finish} = $self->token($elem, $elem->finish);
        }
        elsif ($elem->isa('PPI::Token')) {
            $elem->{__perlingual_content} = $self->token($elem, $elem->content);
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

sub token {
    my ($self, $elem, $token) = @_;
    return unless $token;
    
    my $class = $elem->class;
       $class =~ s/^PPI:://;
       $class = $self->namespace . '::' . $class;
    
    try {
        require_module($class);
    } catch {
        # one more challenge
        try {
            $class =~ s/::[^:]+$//;
            require_module($class);
        };
    };

    if (try { $class->can('to_php') }) {
        return $class->to_php($elem, $token);
    }
    
    return $token; # give up or same as php

}

1;
