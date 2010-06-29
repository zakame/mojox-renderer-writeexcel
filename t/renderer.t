#!perl

use strict;
use warnings;

use Test::More tests => 3;
use Test::Mojo;

use FindBin;
$ENV{MOJO_HOME} = "$FindBin::Bin";
require "$ENV{MOJO_HOME}/DemoXls";

# Test
my $t = Test::Mojo->new;

$t->get_ok('/demo.xls')
  ->status_is(200)->content_type_is('application/vnd.ms-excel');
