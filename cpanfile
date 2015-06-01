requires 'perl', '5.010001';

requires 'Data::Dump';
requires 'Encode';
requires 'File::Temp';
requires 'IO::File';
requires 'Module::Metadata';
requires 'Module::Runtime';
requires 'Moo';
requires 'parent';
requires 'PPI';
requires 'Ref::List';
requires 'Role::Tiny';
requires 'Try::Tiny';

on 'test' => sub {
    requires 'Test::More', '0.98';
};
