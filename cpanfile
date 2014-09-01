requires 'perl', '5.010001';

requires 'Data::Dump';
requires 'Encode';
requires 'File::Temp';
requires 'IO::File';
requires 'JSON' => '>= 2.90';
requires 'JSON::XS';
requires 'Module::Runtime';
requires 'Moo';
requires 'parent';
requires 'Plack';
requires 'Plack::Builder';
requires 'PPI';
requires 'Ref::List';
requires 'Try::Tiny';

on 'test' => sub {
    requires 'Test::More', '0.98';
};
