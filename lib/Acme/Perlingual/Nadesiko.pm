package Acme::Perlingual::Nadesiko;
use strict;
use warnings;
use utf8;
use Moo;

with 'Acme::Perlingual::Lang';

sub comment_prefix { '// ' }

sub prepare {
    my ($self) = @_;
    
    # remove shebang
    $self->{source} =~ s/^#!.*\r?\n//;
}

sub finalize {
    my ($self) = @_;
    
    # added 1st <?php line instead of shebang
    unshift(@{ $self->lines }, "// なでしこ by perlingual\n");
}

1;
