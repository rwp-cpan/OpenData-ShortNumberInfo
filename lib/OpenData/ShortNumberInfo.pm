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
