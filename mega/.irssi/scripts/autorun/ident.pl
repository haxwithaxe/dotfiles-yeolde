# Example how to create your own /commands:

# /HELLO <nick> - sends a "Hello, world!" to given nick.

use Irssi;
use strict;
use vars qw($VERSION %IRSSI);

$VERSION = "1.00";
%IRSSI = (
    authors     => 'Timo Sirainen',
    name        => 'command',
    description => 'Command example',
    license     => 'Public Domain'
);

sub cmd_ident {
	my ($data, $server, $channel) = @_;

	my %pass = (
          darkirc => '^^y1rcp4**vv0rd',
          hacdc => '^^y1rcp455',
        );

	$server->command("/nickserv identify $pass{$data}");
}

Irssi::command_bind('ident', 'cmd_ident');
