package Mojolicious::Plugin::WriteExcel;

use Mojo::Base 'Mojolicious::Plugin';
use Spreadsheet::WriteExcel::Simple;

our $VERSION = '2.0';

# You just have to give guys a chance. Sometimes you meet a guy and
# think he's a pig, but then later on you realize he actually has a
# really good body.
sub xls_renderer {
  my ($r, $c, $output, $options) = @_;

  # don't let MojoX::Renderer to encode output to string
  delete $options->{encoding};

  my $ss       = Spreadsheet::WriteExcel::Simple->new;
  my $heading  = $c->stash->{heading};
  my $result   = $c->stash->{result};
  my $settings = $c->stash->{settings};

  if (ref $heading) {
    $ss->write_bold_row($heading);
  }

  if (ref $settings) {
    $c->render_exception("invalid column width")
      unless defined $settings->{column_width};
    for my $col (keys %{$settings->{column_width}}) {
      $ss->sheet->set_column($col, $settings->{column_width}->{$col});
    }
  }

  foreach my $data (@$result) {
    $ss->write_row($data);
  }

  $$output = $ss->data;
}

sub register {
  my ($self, $app) = @_;

  $app->types->type(xls => 'application/vnd.ms-excel');
  $app->renderer->add_handler(xls => \&xls_renderer);
  $app->helper(
    render_xls => sub {
      shift->render(handler => 'xls', @_);
    }
  );
}

1;
__END__

=head1 NAME

Mojolicious::Plugin::WriteExcel - Spreadsheet::WriteExcel plugin

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('write_excel');

  # Mojolicious::Lite
  plugin 'write_excel';

  # Render a spreadsheet
  get '/example.xls' => sub {
    shift->render(
      handler => 'xls',
      result  => [[qw(foo bar baz)], [qw(lol wut bbq)], [qw(kick ass module)],],
    );
  };


=head1 DESCRIPTION

L<Mojolicious::Plugin::WriteExcel> is a renderer for Excel spreadsheets.

This plugin converts the C<result> element in the stash to an Excel
spreadsheet.  If the stash also has a C<heading> element, the renderer
will also write headings in bold type for the columns in the
spreadsheet.

C<heading> is an arrayref, while C<result> is an array of arrayrefs.

Optionally, a C<settings> parameter can be provided to set additional
attributes in the Excel spreadsheet.  Currently 'column_width' is the
only working attribute.  C<settings> is a hashref.  Column widths
could be set by passing the settings to render such as:

   settings => {column_width => {'A:A' => 10, 'B:B' => 25, 'C:D' => 40}}

=head1 METHODS

L<Mojolicious::Plugin::WriteExcel> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 xls_renderer

  $app->renderer->add_handler(xls => \&xls_renderer);

Internal sub talking to L<Spreadsheet::WriteExcel::Simple> to render
spreadsheets.

=head2 C<register>

  $plugin->register;

Register renderer in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Spreadsheet::WriteExcel::Simple>, L<http://mojolicious.org>.

=cut
