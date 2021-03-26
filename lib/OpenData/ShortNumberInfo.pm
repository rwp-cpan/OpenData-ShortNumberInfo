package OpenData::ShortNumberInfo;
use v5.32;
use HTTP::Tiny;
use Data::Dumper qw();
# use Encode ();
use URI; # cpan: URI (distribution)
use JSON; # cpan: JSON (distribution)
# use utf8;
use experimental qw(signatures);
use constant PATH => qw(v1 json nrytn ShortNumberInfo);

my $uri = URI -> new('https://api.opendata.az');
my $http = HTTP::Tiny -> new();
my $json = JSON -> new();
my $content;

sub new($class, $name)
{
  $uri -> path_segments(PATH, $name);
  my $get = $http -> get($uri); # return value: hash reference
  # die Data::Dumper::Dumper $get;
  $content = $json -> decode($get -> {content});
  return bless( {url => $uri}, $class );
}

sub status($object)
{
  return $content -> {Status};
}

sub status_message($object)
{
  return $content -> {StatusMessage};
}

sub name($object)
{
  return $content -> {Response} -> [0] -> {Name};
}

sub tariff_baku($object)
{
  return $content -> {Response} -> [0] -> {TariffBaku};
}

sub tariff_region($object)
{
  return $content -> {Response} -> [0] -> {TariffRegion};
}

1;

=pod

=head1 NAME

OpenData::ShortNumberInfo.pm - interface module to OpenData ShortNumberInfo API service

=head1 SYNOPSIS

use OpenData::ShortNumberInfo;

my shortnumberinfo = OpenData::ShortNumberInfo -> new(169);

say shortnumberinfo -> name();

=head1 DESCRIPTION 

=head2 METHODS

=over

=item status

server response status code (one of OK, InputError, and ServerError)

=item status_message

server response status message (usually null)

=item name

the organization the number belongs to

=item tariff_baku

tarriff for calls from baku (capital) in azn (currency)

=item tariff_region

tarriff for calls from outside (regions) of baku in azn (currency)

=back

=head1 SEE ALSO

L<OpenData API documentation|https://www.opendata.az/en/home/developers/>

=cut
