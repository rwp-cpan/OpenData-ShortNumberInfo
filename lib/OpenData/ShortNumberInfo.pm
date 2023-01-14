package OpenData::ShortNumberInfo;

use v5.36;
use Object::Pad;

class OpenData::ShortNumberInfo {
	use HTTP::Tiny;
	use URI;
	use JSON;

	field $number :param //= 103;

	method name ( ) {
		# Construct API URL
		my $uri = URI -> new( 'https://api.opendata.az' );
		$uri -> path_segments( qw( v1 json nrytn ShortNumberInfo ), $number );

		# Issue HTTP request to get the web page
		my $http = HTTP::Tiny -> new();
		my $response = $http -> get( $uri ); # RV: HR

		# Convert JSON from HTTP response into Perl hash
		my $json = JSON -> new();
		my $content = $json -> decode( $response -> {content} );

		unless ( defined( $content -> {StatusMessage} ) ) {
			return $content -> {Response} -> [0] -> {Name};
		}
		else {
			STDERR -> say( $content -> {StatusMessage} );
			exit 2;
		}
	}
}
