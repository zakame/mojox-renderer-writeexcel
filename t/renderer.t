#!perl

use strict;
use warnings;

use Test::More tests => 12;
use Test::Mojo;

use File::Basename 'dirname';
use File::Spec::Functions 'splitdir';
$ENV{MOJO_HOME} = join '/', splitdir(dirname(__FILE__));
require "$ENV{MOJO_HOME}/DemoXls";

$ENV{MOJO_LOG_LEVEL} ||= "fatal";

# Test
my $t = Test::Mojo->new;

$t->get_ok('/demo.xls')
  ->status_is(200)->content_type_is('application/vnd.ms-excel');

$t->get_ok('/demo_without_heading.xls')
  ->status_is(200)->content_type_is('application/vnd.ms-excel');

$t->get_ok('/demo_with_column_width.xls')
  ->status_is(200)->content_type_is('application/vnd.ms-excel');

$t->get_ok('/demo_with_broken_column_width_1.xls')
  ->status_is(500)->content_type_is('text/html');
