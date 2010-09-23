#!perl

use Test::More;

eval "use Spreadsheet::ParseExcel::Simple";
plan skip_all =>
  "Spreadsheet::ParseExcel::Simple required for testing renderer correctness"
  if $@;

ok("it works!");

done_testing;
