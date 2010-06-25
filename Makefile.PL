use inc::Module::Install;

name     'MojoX-Renderer-WriteExcel';
all_from 'lib/MojoX/Renderer/WriteExcel.pm';
author   q{Zak B. Elep <zakame@cpan.org>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

