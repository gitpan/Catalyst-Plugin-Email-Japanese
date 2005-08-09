package Catalyst::Plugin::Email::Japanese;

use strict;
use MIME::Lite::TT::Japanese;

our $VERSION = '0.01';

=head1 NAME

Catalyst::Plugin::Email::Japanese - Send Japanese emails with Catalyst

=head1 SYNOPSIS

  use Catalyst qw/Email::Japanese/;

  __PACKAGE__->config->{email} = {
      Template => 'email.tt',
      From => 'typester@cpan.org',
  };

  $c->email(
      To => 'typester@gmail.com',
      Subject => 'Hi!',
  );

=head1 DESCRIPTION

Send emails with Catalyst and L<MIME::Lite::TT::Japanese>.

=head2 METHODS

=head3 email

=cut

sub email {
    my $c = shift;
    my $args = $_[1] ? {@_} : $_[0];

    my $template = $args->{Template} || $c->stash->{email}->{template} || $c->config->{email}->{Template};

    my $options = {
        EVAL_PERL => 0,
        INCLUDE_PATH => [ $c->config->{root}, $c->config->{root}.'/base' ],
        %{ $c->config->{email}->{TmplOptions} || {} },
        %{ $args->{TmplOptions} || {} },
    };

    my $params = {
        base => $c->req->base,
        c => $c,
        name => $c->config->{name},
        %{ $c->stash },
        %{ $args->{TmplParams} || {} },
    };

    MIME::Lite::TT::Japanese->new(
        %{$c->config->{email} || {} },
        %{$args || {} },
        Template => $template,
        TmplParams => $params,
        TmplOptions => $options,
        Icode => $args->{Icode} || $c->config->{email}->{Icode} || 'utf8',
        LineWidth => $args->{LineWidth} || $c->config->{email}->{LineWidth} || 0,
    )->send;
}

=head1 SEE ALSO

L<Catalyst>, L<Catalyst::Plugin::Email>, L<MIME::Lite::TT::Japanese>.

=head1 AUTHOR

Daisuke Murase, E<lt>typester@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
