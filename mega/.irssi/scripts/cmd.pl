# Example how to create your own /commands:


use Irssi;
use strict;
use vars qw($VERSION %IRSSI);

$VERSION = "1.00";
%IRSSI = (
    authors     => 'haxwithaxe',
    name        => 'funfact',
    description => 'crap out strings on command',
    license     => 'Public Domain'
);

sub mkfactcmd($$) {
	Irssi::command_bind $_[0] => sub { $witem->print($_[1]) };
}

sub unmkfact($){
	Irssi::command_bind $_[0];
}

sub setfact {
	my ($data, $server, $channel) = @_;
	return unless $witem;
	return unless $data;
	my $factname, $facttext = split(' ', $data, 1);
	mkcmd($factname, $facttext);
	$witem->print('Registered '.$factname.' as '.$facttext);
}

sub unsetfact {
        my ($data, $server, $channel) = @_;
        return unless $witem;
        return unless $data;
        my $factname, $facttext = split(' ', $data, 1);
        unmkcmd($factname);
        $witem->print('Unregistered '.$factname);
}

Irssi::command_bind 'setfact' => \&setfact;
Irssi::command_bind 'unsetfact' => \&unsetfact;
