package Acme::P2P::Doc;
use strict;
use warnings;
use Module::Runtime qw/require_module/;
use PPI::Document;
use Try::Tiny;
use Moo;

has source => (is => 'rw');

sub to_php {
    my ($self) = @_;
    
    my $source = $self->source || "";

    # replace before parse ...
    {
        $source =~ s/^#!.*\r?\n//; # remove shebang
        
        # cheating ...!
        $source =~ s!(\$self\s*=\s*)shift!$1\$this!g;
        $source =~ s!\((\$self\s*,[^\)]+)\)\s*=\s*\@_\s*;!list($1) = array(\$this, func_get_args()); # tekito!g;
        $source =~ s!\(([^\)]+)\)\s*=\s*\@_\s*;!list($1) = func_get_args(); # tekito!g;
    
        # cheating ...!
        $source =~ s!for\s+(?:my)?\s*([^\(]+?)\s*\(([^\)]+)\)!foreach ($2 as $1)!g;
    }
    
    my $doc = PPI::Document->new(\$source);
    
    # add $elem->{__php_xxx} ...
    __walk($doc, sub {
        my ($elem, $token) = @_;
        if ($elem->isa('PPI::Structure')) {
            $elem->{__php_start}  = __token_to_php($elem, $elem->start);
            $elem->{__php_finish} = __token_to_php($elem, $elem->finish);
        }
        elsif ($elem->isa('PPI::Token')) {
            $elem->{__php_content} = __token_to_php($elem, $elem->content);
        }
    });
    
    # join all $elem->{__php_xxx} ...
    my @lines;
    __walk($doc, sub {
        my ($elem, $token) = @_;
        return if $elem->{__php_skip};
        return unless defined $token;
        push @lines, $token;
    });
    
    my $out = join "", @lines;

    # fixes after parse
    {
        $out = "<?php\n" . $out; # finally add <?php
    }
    
    $out;
}

sub __walk {
    my ($elem, $callback) = @_;
    
    # skip PPI::Document, PPI::Statement
    
    if ($elem->isa('PPI::Structure')) {
        $callback->($elem, $elem->{__php_start} // $elem->start);
    }

    if ($elem->isa('PPI::Node') and not $elem->{__php_skip}) {
        for my $child_node ($elem->children) {
            __walk($child_node, $callback);
        }
    }
    elsif ($elem->isa('PPI::Token')) {
        $callback->($elem, $elem->{__php_content} // $elem->content);
    }
    
    if ($elem->isa('PPI::Structure')) {
        $callback->($elem, $elem->{__php_finish} // $elem->finish);
    }
}

sub __token_to_php {
    my ($elem, $token) = @_;
    return unless $token;
    
    my $module = $elem->class;
       $module =~ s/^PPI::/Acme::P2P::Doc::/;
    
    try {
        require_module($module);
    } catch {
        # one more challenge
        try {
            $module =~ s/::[^:]+$//;
            require_module($module);
        };
    };

    if (try { $module->can('to_php') }) {
        return $module->to_php($elem, $token);
    }
    
    return $token; # give up or same as php
}

1;
