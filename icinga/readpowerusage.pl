#!/usr/bin/perl 

# Set the USB port where the Arduino is connected
my $port = "/dev/ttyUSB0";
if(!-r $port) {
	die "Can't open $port for reading!\n";
}
# Adjust the port settings using stty:
system("stty -F $port cs8 9600 ignbrk -brkint -icrnl -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts");

use strict;
use warnings;

# DB Settings
use DBI;
my $dbuser = "power";
my $dbpasswd = "<YOURSQLUSERPASSWORD>";
my $dbname = "dbi:mysql:powerusage";
my $dbtable = "log";

my $dbh = DBI->connect($dbname,$dbuser,$dbpasswd) or die "Connection Error: $DBI::errstr\n";

open(IN, "<", "$port") or die "Can't open USB port\n";
while (<IN>) {
	# Poll to see if any data is coming in
	my $char = $_;
	chomp $char;
	
	# If we get data, then print it
	# Send a number to the arduino
	if ($char) {
		print "$char\n";
		if($char =~ /#\d* Blinks: (\d*)/) {
			my $timestamp = time();
			my $query = $dbh->prepare("insert into $dbtable (timestamp,blinks) values ($timestamp, $1)");
			$query->execute();
			$query->finish();
			print "Received blinks: $1\n";
		}
	}
}

