package Acme::Perlingual::Php53;
use strict;
use warnings;
use utf8;
use File::Temp;
use Encode;
use Moo;

with 'Acme::Perlingual::Lang';

sub comment_prefix { '// ' }

sub check {
    my ($self) = @_;
    my $temp = File::Temp->new();
    my $source = $self->source;
    $temp->print("<?php\n") if $source !~ /^<\?/m;
    $temp->print(encode_utf8 $source);
    
    my $out = qx(cat $temp | php -l 2>&1 1>/dev/null);
    return if $? == 0;
    return $out;
}

sub prepare {
    my ($self) = @_;
    
    # remove shebang
    $self->{source} =~ s/^#!.*\r?\n// and $self->{shebang} = 1;
    
    # cheating ...!
    $self->{source} =~ s!(\$self\s*=\s*)shift!$1\$this!g;
    $self->{source} =~ s!\((\$self\s*,[^\)]+)\)\s*=\s*\@_\s*;!list($1) = array(\$this, func_get_args()); # tekito!g;
    $self->{source} =~ s!\(([^\)]+)\)\s*=\s*\@_\s*;!list($1) = func_get_args(); # tekito!g;

    # cheating more ...!
    $self->{source} =~ s!for\s+(?:my)?\s*([^\(]+?)\s*\(([^\)]+)\)!foreach ($2 as $1)!g;
}

sub finalize {
    my ($self) = @_;
    
    # added 1st <?php line instead of shebang
    unshift(@{ $self->lines }, "<?php\n") if $self->{shebang};
}

1;
