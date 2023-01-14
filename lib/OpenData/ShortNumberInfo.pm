package OpenData::ShortNumberInfo;
# ABSTRACT: Perl interface to OpenData ShortNumberInfo web service

=head1 SYNOPSIS

  use OpenData::ShortNumberInfo;

  my $shortnumberinfo =
	  OpenData::ShortNumberInfo -> new( number => 101 );

  say $shortnumberinfo -> name();

=cut

use v5.36;
use Object::Pad;

class OpenData::ShortNumberInfo {
	use HTTP::Tiny;
	use URI;
	use JSON;

	field $number :param //= 103;

	# TODO: accessor $name

=method name

Take a 3 digit phone number and return the organization it belongs to
Prints a message to standard error stream exiting with the status code of 2
if there's no organization for the number specified

=cut

	method name ( $number ) {
		# Construct API URL
		my $uri = URI -> new( 'https://api.opendata.az' );
		$uri -> path_segments(
			'v1',              # version
			'json',            # format
			'nrytn',           # organization
			'ShortNumberInfo', # service
			$number            # parameter
		);

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


=head1 SEE ALSO

=for :list
* Your::Module
* Your::Package
