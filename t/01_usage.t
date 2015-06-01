use strict;
use warnings;
use Test::More;
use Acme::Perlingual;

my $source = <<'...';
my $foo = "foo";

if ($foo =~ /oo/) {
    print $foo;
} elsif ($foo) {
    print q{"boo"};
}
...

my $doc = Acme::Perlingual->new(source => $source);
my $php = $doc->convert('php53');

is($php->as_string, <<'...');
<?php
$foo = "foo";

if (preg_match('/oo/', $foo)) {
    print $foo;
} elseif ($foo) {
    print '"boo"';
}
...

done_testing();
