package Mojolicious::Plugin::Paging;
use Mojo::Base 'Mojolicious::Plugin';
use Mojolicious::Page;

our $VERSION = '0.0.1';

sub register{
  my ($self, $app) = @_;
  if(!Mojolicious::Controller->can('page')){
    Mojolicious::Controller->attr(page => sub{
        my $c = shift;
        my $v = $c->validation;
        $v->optional("page", "trim");
        $v->num;
        $v->optional("pre_page", "trim");
        $v->num;
        my $p = $v->output;
        return Mojolicious::Page->new(
          url          => $c->url_with,
          current_page => $p->{page},
          pre_page_row => $p->{pre_page}
        );
      }
    );
  }
}

1;
__END__

=encoding utf8

=head1 NAME

Mojolicious::Plugin::Paging - Mojolicious paging Plugin

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('Paging');

  # Mojolicious::Lite
  plugin 'Paging';

=head1 DESCRIPTION

L<Mojolicious::Plugin::Paging> is a L<Mojolicious> plugin.

=head1 METHODS

L<Mojolicious::Plugin::Paging> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicious.org>.

=cut
