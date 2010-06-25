use inc::Module::Install;

name     'MojoX-Renderer-WriteExcel';
all_from 'lib/MojoX/Renderer/WriteExcel.pm';
license  'perl';

build_requires 'Test::More';

resources repository => 'git://github.com/zakame/mojox-renderer-writeexcel.git';

requires 'Spreadsheet::WriteExcel::Simple';

auto_install;

WriteAll;

