#!perl

BEGIN {
    unless ( $ENV{RELEASE_TESTING} ) {
        require Test::More;
        Test::More::plan(
            skip_all => 'these tests are for release candidate testing' );
    }
}

use Test::More;

eval "use Spreadsheet::ParseExcel::Simple";
plan skip_all =>
  "Spreadsheet::ParseExcel::Simple required for testing renderer correctness"
  if $@;

ok("it works!");

done_testing;
