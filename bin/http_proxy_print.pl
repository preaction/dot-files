#!/usr/bin/env perl

$|++;
use strict; use warnings;
use IO::All;

my $remote_host = $ARGV[0] or die "Host must be first argument";
my $remote_port = $ARGV[1] || 80;
if ( $remote_host =~ /:/ ) {
    ( $remote_host, $remote_port ) = split /:/, $remote_host;
}
my $local_host = "localhost";
my $local_port = 8080;
my $remote_id = join( ":", $remote_host, $remote_port );

my $socket = io(":$local_port")->fork->accept;
my $remote = io($remote_id);
print "--- REQUEST $remote_id ---\n";
my $req = $socket->getline;
print $req;
my $in_head = 1;
my %head = ();
my $body = '';
while ( my $line = $socket->getline ) {
    if ( $line =~ /^\r\n$/ ) {
        $in_head = 0;
    }
    elsif ( $in_head ) {
        my ( $key, $value ) = $line =~ /^([^:\s]+)\s*:\s*(.+)\r\n/;
        $head{ lc $key } = $value;
    }
    else {
        $body .= $line;
        if ( length $body eq $head{"content-length"} ) {
            last;
        }
    }
    print $line;
}
print "--- /REQUEST ---\n";

# Mangle request
# -- Replace instance of $local_host with $remote_host
$body =~ s/$local_host/$remote_host/g;
$head{host} = $remote_host;
# -- Update content-length since we modified body
$head{ 'content-length' } = length $body;

# Send request
$remote->print( $req );
for my $key ( keys %head ) {
    my $line = join ":", $key, $head{$key};
    $remote->print( "$line\r\n" );
}
$remote->print( "\r\n", $body );


print "--- RESPONSE ---\n";
while ( my $line = $remote->getline ) {
    print $line;
    $socket->print( $line );
}
print "\n--- /RESPONSE ---\n";
$remote->close;
$socket->close;

