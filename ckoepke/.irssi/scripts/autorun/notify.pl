##
## Put me in ~/.irssi/scripts, and then execute the following in irssi:
##
##       /load perl
##       /script load notify
##

use strict;
use Irssi;
use vars qw($VERSION %IRSSI);
use HTML::Entities;

$VERSION = "0.1";
%IRSSI = (
    authors     => 'Luke Macken, Paul W. Frields',
    contact     => 'lewk@csh.rit.edu, stickster@gmail.com',
    name        => 'notify.pl',
    description => 'Use D-Bus to alert user to hilighted messages',
    license     => 'GNU General Public License',
    url         => 'http://code.google.com/p/irssi-libnotify',
);

Irssi::settings_add_str('notify', 'notify_remote', '');
Irssi::settings_add_bool('notify', 'notify_debug', 0);
Irssi::settings_add_str('notify', 'notifier_path', '');

Irssi::settings_add_str('notify', 'notify_highlight_prefix', '');
Irssi::settings_add_str('notify', 'notify_highlight_suffix', '!');
Irssi::settings_add_str('notify', 'notify_highlight_fgcolor', '#000000');
Irssi::settings_add_str('notify', 'notify_highlight_bgcolor', '#fadf23');

Irssi::settings_add_str('notify', 'notify_privmsg_prefix', '');
Irssi::settings_add_str('notify', 'notify_privmsg_suffix', '>');
Irssi::settings_add_str('notify', 'notify_privmsg_fgcolor', '#000000');
Irssi::settings_add_str('notify', 'notify_privmsg_bgcolor', '#fadf23');

Irssi::settings_add_str('notify', 'notify_dcc_prefix', 'DCC ');
Irssi::settings_add_str('notify', 'notify_dcc_suffix', '');
Irssi::settings_add_str('notify', 'notify_dcc_fgcolor', '#000000');
Irssi::settings_add_str('notify', 'notify_dcc_bgcolor', '#fadf23');

 
#<Ctrl>-b        set bold
#<Ctrl>-c#[,#]   set foreground and optionally background color
#<Ctrl>-o        reset all formats to plain text
#<Ctrl>-v        set inverted color mode
#<Ctrl>-_        set underline
#<Ctrl>-7

sub sanitize {
  my ($text) = @_;
  encode_entities($text,'\'<>&');
  my $apos = "&#39;";
  my $aposenc = "\&apos;";
  $text =~ s/$apos/$aposenc/g;
  $text =~ s/"/\\"/g;
  $text =~ s/\$/\\\$/g;
  $text =~ s/`/\\"/g;
  $text =~ s/\cb([\w\s#\/\\'"\*.><()\[\]&;:_-]+)(\cb|\co)/<b>$1<\/b>/g;
  $text =~ s/\c_([\w\s#\/\\'"\*.><()\[\]&;:_-]+)(\c_|\co)/<u>$1<\/u>/g;
  $text =~ s/\cv([\w\s#\/\\'"\*.><()\[\]&;:_-]+)(\cv|\co)/<i>$1<\/i>/g;
  $text =~ s/\cc[0-9]+([\w\s#\/\\'"\*.><()\[\]&;:_-]+)(\cc[0-9]+|\co)/$1/g;
  $text =~ s/\s+$//;
  $text =~ s/^\s+//;
  return $text;
}

    
sub notify {
    my ($server, $fgcolor, $bgcolor, $summary, $message) = @_;

    # Make the message entity-safe
    $summary = sanitize($summary);
    $message = sanitize($message);
	return if (length $message < 1);
	my $debug_str = Irssi::settings_get_str('notify_debug') ? "" : "-";
    my $cmd = "EXEC ".$debug_str." notify-send -h string:fgcolor:".$fgcolor." -h string:bgcolor:".$bgcolor." --category=im.received \'" . $summary . "\' \'" . $message . "\'";
    $server->command($cmd);
}

sub handle_print_text {
    my ($dest, $text, $stripped) = @_;
    my $server = $dest->{server};

    return if (!$server || !($dest->{level} & MSGLEVEL_HILIGHT));

    my $sender = $stripped;
    $sender =~ s/^\<.([^\>]+)\>.+/\1/ ;
    $stripped =~ s/^\<.[^\>]+\>.// ;

	my $prefix = Irssi::settings_get_str('notify_highlight_prefix');
	my $suffix = Irssi::settings_get_str('notify_highlight_suffix');
	my $fgcolor = Irssi::settings_get_str('notify_highlight_fgcolor');
	my $bgcolor = Irssi::settings_get_str('notify_highlight_bgcolor');

    my $summary = $dest->{target} . ": " . $sender;
    notify($server, $fgcolor, $bgcolor, $prefix.$summary.$suffix, $stripped);
}

sub handle_message_private {
    my ($server, $msg, $nick, $address) = @_;

	$msg =~ s/\[$server->{nick}\]//;

	my $prefix = Irssi::settings_get_str('notify_privmsg_prefix');
	my $suffix = Irssi::settings_get_str('notify_privmsg_suffix');
	my $fgcolor = Irssi::settings_get_str('notify_privmsg_fgcolor');
	my $bgcolor = Irssi::settings_get_str('notify_privmsg_bgcolor');
	notify($server, $fgcolor, $bgcolor, $prefix.$nick.$suffix, $msg);
}

sub handle_message_public {
    my ($server, $msg, $nick, $address) = @_;

	my $active_window = Irssi::active_win();
	$msg =~ s/\[$server->{nick}\]//;
	return if ($active_window->{level} < MSGLEVEL_HILIGHT);

	my $prefix = Irssi::settings_get_str('notify_privmsg_prefix');
	my $suffix = Irssi::settings_get_str('notify_privmsg_suffix');
	my $fgcolor = Irssi::settings_get_str('notify_privmsg_fgcolor');
	my $bgcolor = Irssi::settings_get_str('notify_privmsg_bgcolor');

    notify($server, $fgcolor, $bgcolor, $prefix.$nick.$suffix, $msg);
}

sub handle_dcc_request {
    my ($dcc, $sendaddr) = @_;
    my $server = $dcc->{server};

	my $prefix = Irssi::settings_get_str('notify_dcc_prefix');
	my $suffix = Irssi::settings_get_str('notify_dcc_suffix');
	my $fgcolor = Irssi::settings_get_str('notify_dcc_fgcolor');
	my $bgcolor = Irssi::settings_get_str('notify_dcc_bgcolor');

    return if (!$dcc);
    notify($server, $fgcolor, $bgcolor, $prefix.$dcc->{type}.$suffix, $dcc->{nick});
}

Irssi::signal_add('print text', 'handle_print_text');
Irssi::signal_add('message private', 'handle_message_private');
Irssi::signal_add('message public', 'handle_message_public');
Irssi::signal_add('dcc request', 'handle_dcc_request');
