use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/extlib/lib/perl5";
use lib "$FindBin::Bin/lib";
use Encode;
use JSON;
use Plack::Request;

use Acme::P2P;

my $app = sub {
    my $env = shift;
    my $req = Plack::Request->new($env);
    
    my $res = Acme::P2P->new->perl2php(decode_utf8 $req->param('input'));
    my $body = encode_json($res);

    return [
        200,
        ['Content-Type' => 'application/json; charset=utf-8'],
        [ $body ],
    ];
};

