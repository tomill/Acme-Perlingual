package Acme::P2P::Perl;
use strict;
use warnings;
use Encode;
use File::Temp;

sub syntax_check {
    my ($self, $source) = @_;
    
    my $temp = File::Temp->new();
    
    print {$temp} encode_utf8($source);
    
    my $filename = $temp->filename;
    my $out = qx(perl -c $filename 2>&1);
    return if $? == 0;
    
    $out =~ s!$filename!<source>!gms;
    $out =~ s/<source> had compilation errors.\n//;
    $out =~ s/^\s*\n//gm;
    chomp $out;
    
    return unless $out;
    return 'Perl Parse error:  ' . $out;
}

1;
