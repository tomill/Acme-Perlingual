use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/extlib/lib/perl5";
use lib "$FindBin::Bin/lib";
use Data::Dump qw/dump/;
use JSON;
use Plack::Request;

my $app = sub {
    my $env = shift;
    my $req = Plack::Request->new($env);
    
    my $body = encode_json($req->parameters->mixed);

    return [
        200,
        ['Content-Type' => 'application/json; charset=utf-8'],
        [ $body ],
    ];
};

