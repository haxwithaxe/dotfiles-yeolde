# by Stefan 'tommie' Tomanek <stefan@pico.ruhr.de>
#
#

use strict;

use Regexp::Assemble;

use vars qw($VERSION %IRSSI);
$VERSION = "20110926";
%IRSSI = (
    authors     => "haxwithaxe",
    contact     => "spam\@haxwithaxe.net",
    name        => "pounce",
    description => "Postpones messages sent to a splitted user and resends them when the nick rejoins",
    license     => "GPLv2",
    changed     => "$VERSION",
    commands     => "pounce"
);

use Irssi 20020324;
use vars qw(%messages);

sub draw_box ($$$$) {
    my ($title, $text, $footer, $colour) = @_;
    my $box = '';
    $box .= '%R,--[%n%9%U'.$title.'%U%9%R]%n'."\n";
    foreach (split(/\n/, $text)) {
        $box .= '%R|%n '.$_."\n";
    }
    $box .= '%R`--<%n'.$footer.'%R>->%n';
    $box =~ s/%.//g unless $colour;
    return $box;
}

sub show_help() {
    my $help="Pounce $VERSION
/pounce help
    Display this help
/pounce <nick> <message>
    add a pounce for aproximately <nick>
/pounce exactly (<nick>|<pattern>) <message>
    add a pounce for exactly (<nick>|<pattern>)
/pounce flush <nick>
    Flush pounces to <nick>
/pounce list
    List pounce messages
";
    my $text = '';
    foreach (split(/\n/, $help)) {
        $_ =~ s/^\/(.*)$/%9\/$1%9/;
        $text .= $_."\n";
    }
    print CLIENTCRAP &draw_box("Pounce", $text, "help", 1);
}


my $comment = 'sub event_send_text ($$$) {
    my ($line, $server, $witem) = @_;
    return unless ($witem && $witem->{type} eq "CHANNEL");
    if ($line =~ /^\/pounce (\w+?) (.*)$/) {
	my ($target, $msg) = ($2,$3);
	if ($witem->nick_find($target)) {
	    # Just leave me alone
	    return;
	} else {
	    $witem->print("%B>>%n %U".$target."%U message has been queued: \"".$line."\"", MSGLEVEL_CLIENTCRAP);
	    push @{$messages{$server->{tag}}{$witem->{name}}{$target}}, $line;
	    Irssi::signal_stop();
	}
    }
}';

sub event_message_join ($$$$) {
    my $ra = Regexp::Assemble->new;
    my ($server, $channel, $rnick, $address) = @_;
    return unless (defined $messages{$server->{tag}});
    return unless (defined $messages{$server->{tag}}{$channel});
    $ra->add(@{$messages{$server->{tag}}{$channel}});
    my $nick = $ra->match($rnick);
    return unless (defined $messages{$server->{tag}}{$channel}{$nick});
    return unless (scalar(@{$messages{$server->{tag}}{$channel}{$nick}}) > 0);
    my $chan = $server->channel_find($channel);
    $chan->print("%B>>%n Sending pounce for ".$nick);
    while (scalar(@{$messages{$server->{tag}}{$channel}{$nick}}) > 0) {
	my $msg = pop @{$messages{$server->{tag}}{$channel}{$nick}};
	sleep 2;
	$server->command('MSG '.$channel.' '.$msg);
    }
    
}

sub nick_re ($$) {
	my ($nick, $type) = @_;
	if (defined $type) {
		if ($type eq "") {
	                return '/[-_]*'.$nick.'[-_]*/i';
		} else {
			return $nick; #FIXME
		}
	} else {
		return '/[-_]*'.$nick.'[-_]*/i';
	}
}

sub cmd_pounce ($$$) {
    my ($args, $server, $witem) = @_;
    my @arg = split(/ /, $args);
    if (scalar(@arg) < 1) {
	show_help();
    } elsif ($arg[0] eq 'flush') {
	if (defined $arg[1]) {
		print CLIENTCRAP 'Flushing messages to '.$arg[1];
		if (defined $arg[2]) {
			while (scalar(@{$messages{$server->{tag}}{$arg[2]}{$arg[1]}}) > 0) {
                            my $msg = pop @{$messages{$server->{tag}}{$arg[2]}{$arg[1]}};
                        }
			my $nick_regex = nick_re($arg[1], "");
			while (scalar(@{$messages{$server->{tag}}{$arg[2]}{$nick_regex}}) > 0) {
                            my $msg = pop @{$messages{$server->{tag}}{$arg[2]}{$nick_regex}};
                        }
		} else {
			return unless ($witem && $witem->{type} eq "CHANNEL");
			while (scalar(@{$messages{$server->{tag}}{$witem->{name}}{$arg[1]}}) > 0) {
			    my $msg = pop @{$messages{$server->{tag}}{$witem->{name}}{$arg[1]}};
			}
                        my $nick_regex = nick_re($arg[1], "");
                        while (scalar(@{$messages{$server->{tag}}{$witem->{name}}{$nick_regex}}) > 0) {
                            my $msg = pop @{$messages{$server->{tag}}{$witem->{name}}{$nick_regex}};  
                        }
		}
	} else {
		print CLIENTCRAP "flush requires a nick as an argument";
		show_help();
	}
    } elsif ($arg[0] eq 'list') {
	my $text;
	foreach (keys %messages) {
	    $text .= $_."\n";
	    foreach my $channel (keys %{$messages{$_}}) {
		$text .= " %U".$channel."%U \n";
		foreach my $nick (sort keys %{$messages{$_}{$channel}}) {
		    $text .= $nick.' |'.$_."\n" foreach @{$messages{$_}{$channel}{$nick}};
		}
	    }
	}
	print CLIENTCRAP &draw_box('Pounce', $text, 'messages', 1);
    } elsif ($arg[0] eq 'help') {
	show_help();
    } else {
	if (scalar(@arg) > 2) {
		my $msgIndex = 1;
                my $nick = '/[-_]*'.$arg[0].'[-_]*/i';
		if ($arg[0] eq 'exactly') {
			$nick = $arg[1];
			$msgIndex = 2;
		}
		my $msg = join(' ',@arg[$msgIndex .. $#arg]);
		print CLIENTCRAP $nick.' '.$msg;
		if (defined $witem) {
			$witem->print("%B>>%n %U".$nick."%U message has been queued: \"".$msg."\"", MSGLEVEL_CLIENTCRAP);
			push @{$messages{$server->{tag}}{$witem->{name}}{$nick}},$msg;
		} else {
			print CLIENTCRAP "ERROR: No channel. Message not queued.";
		}
		Irssi::signal_stop();
	} else {
		show_help();
	}
    }
}

Irssi::command_bind('pounce', \&cmd_pounce);

Irssi::signal_add('message join', \&event_message_join);

print CLIENTCRAP "%B>>%n Pounce ".$VERSION." loaded: /pounce help for help";

