use inc::Module::Install;

name     'MojoX-Renderer-WriteExcel';
all_from 'lib/MojoX/Renderer/WriteExcel.pm';
author   q{Zak B. Elep <zakame@cpan.org>};
license  'perl';

build_requires 'Test::More';

resources repository => 'http://github.com/zakame/mojox-renderer-writeexcel.git';

requires 'Spreadsheet::WriteExcel::Simple';

auto_install;

WriteAll;

