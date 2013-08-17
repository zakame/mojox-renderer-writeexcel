requires 'Mojolicious', '0.999930';
requires 'Spreadsheet::WriteExcel::Simple';

on test => sub {
    requires 'Test::More';
};
