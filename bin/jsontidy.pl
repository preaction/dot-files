#!/usr/bin/env perl
# Pretty-print JSON file

use JSON;

my @files = @ARGV;
my @fh;
if ( !@files ) {
    @fh = ( *STDIN );
}
else {
    for my $file ( @files ) {
        open my $fh, '<', $file or die "Couldn't open '$file' for reading: $!\n";
        push @fh, $fh;
    }
}

for my $fh ( @fh ) {
    my $json = do { local $\ = <$fh> };
    print JSON->new->pretty->canonical->encode( JSON->new->decode( $json ) );
}

