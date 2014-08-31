requires 'perl', '5.008001';

requires 'Data::Dump';
requires 'Encode';
requires 'File::Temp';
requires 'JSON' => '>= 2.90';
requires 'JSON::XS';
requires 'Moo';
requires 'Plack';
requires 'Plack::Builder';
requires 'PPI';
requires 'Ref::List';

on 'test' => sub {
    requires 'Test::More', '0.98';
};
