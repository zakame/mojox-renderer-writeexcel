requires 'Mojolicious', '4.0';
requires 'Spreadsheet::WriteExcel::Simple', '1.04';

on test => sub {
    requires 'Test::More', '0.98';
};
