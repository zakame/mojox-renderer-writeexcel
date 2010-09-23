#!perl

# Cribbed from mojo's t/mojolicious/lite_app.t:
# Disable epoll, kqueue and IPv6
BEGIN { $ENV{MOJO_POLL} = $ENV{MOJO_NO_IPV6} = 1 }

use Mojo::IOLoop;
use Test::More;

# Make sure sockets are working
plan skip_all => 'working sockets required for this test!'
  unless Mojo::IOLoop->new->generate_port;
plan tests => 1;

eval "use Spreadsheet::ParseExcel::Simple";
plan skip_all =>
  "Spreadsheet::ParseExcel::Simple required for testing renderer correctness"
  if $@;

use Mojolicious::Lite;
use Test::Mojo;

# Mojolicious::Lite and ojo
use ojo;

app->log->level('fatal');

plugin 'write_excel';

my $data =
  [ [qw(Zak B. Elep)], [qw(Joel T Tanangonan)], [qw(Jerome S Gotangco)] ];

get '/demo.xls' => sub {
    shift->render_xls( result => $data, );
};

# Test
my $t      = Test::Mojo->new;
my $port   = $t->client->test_server;
my $demo   = g("http://localhost:$port/demo.xls")->body;
my $result = [];

my $xls = Spreadsheet::ParseExcel::Simple->read( \$demo );
foreach my $sheet ( $xls->sheets ) {
    while ( $sheet->has_data ) {
        push @$result, [ $sheet->next_row ];
    }
}

is_deeply( $result, $data, "spreadsheet matches data set" );
