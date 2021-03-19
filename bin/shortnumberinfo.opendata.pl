use v5.32;
use lib "$ENV{HOME}/var/git/OpenData-ShortNumberInfo/lib";
use Data::Dumper qw();
use OpenData::ShortNumberInfo;

my $shortnumberinfo = OpenData::ShortNumberInfo -> new('169');
my @methods = qw(
  status
  status_message
  name
  tariff_baku
  tariff_region
);

say $shortnumberinfo -> $_() for @methods;;
# die Data::Dumper::Dumper $meaningofname;

=pod

https://en.wikipedia.org/wiki/Azerbaijani_name#Most_popular_names_in_2010-2015_period
https://api.opendata.az/v1/json/home/MeaningOfName/yusif?pretty

=cut
