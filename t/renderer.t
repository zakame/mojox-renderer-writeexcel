#!perl

use strict;
use warnings;

use Test::More tests => 6;
use Test::Mojo;

use File::Basename 'dirname';
use File::Spec::Functions 'splitdir';
$ENV{MOJO_HOME} = join '/', splitdir(dirname(__FILE__));
require "$ENV{MOJO_HOME}/DemoXls";

# Test
my $t = Test::Mojo->new;

$t->get_ok('/demo.xls')
  ->status_is(200)->content_type_is('application/vnd.ms-excel');

$t->get_ok('/demo_without_heading.xls')
  ->status_is(200)->content_type_is('application/vnd.ms-excel');
