use v5.32;
use lib "$ENV{HOME}/var/git/OpenData-ShortNumberInfo/lib";
# use Data::Dumper qw();
use OpenData::ShortNumberInfo;

my $shortnumberinfo = OpenData::ShortNumberInfo -> new($ARGV[0]);

say $shortnumberinfo -> name();

=pod

https://en.wikipedia.org/wiki/Azerbaijani_name#Most_popular_names_in_2010-2015_period
https://api.opendata.az/v1/json/nrytn/ShortNumberInfo/169?pretty

=cut
