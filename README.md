# NAME

Bot::ChatBots::Messenger - Messenger adapter for Bot::ChatBots

# VERSION

This document describes Bot::ChatBots::Messenger version {{\[ version \]}}.

<div>
    <a href="https://travis-ci.org/polettix/Bot-ChatBots-Messenger">
    <img alt="Build Status" src="https://travis-ci.org/polettix/Bot-ChatBots-Messenger.svg?branch=master">
    </a>

    <a href="https://www.perl.org/">
    <img alt="Perl Version" src="https://img.shields.io/badge/perl-5.10+-brightgreen.svg">
    </a>

    <a href="https://badge.fury.io/pl/Bot-ChatBots-Messenger">
    <img alt="Current CPAN version" src="https://badge.fury.io/pl/Bot-ChatBots-Messenger.svg">
    </a>

    <a href="http://cpants.cpanauthors.org/dist/Bot-ChatBots-Messenger">
    <img alt="Kwalitee" src="http://cpants.cpanauthors.org/dist/Bot-ChatBots-Messenger.png">
    </a>

    <a href="http://www.cpantesters.org/distro/B/Bot-ChatBots-Messenger.html?distmat=1">
    <img alt="CPAN Testers" src="https://img.shields.io/badge/cpan-testers-blue.svg">
    </a>

    <a href="http://matrix.cpantesters.org/?dist=Bot-ChatBots-Messenger">
    <img alt="CPAN Testers Matrix" src="https://img.shields.io/badge/matrix-@testers-blue.svg">
    </a>
</div>

# SYNOPSIS

    use Mojolicious::Lite;
    plugin 'Bot::ChatBots::Messenger',
       helper_name => 'messenger', # default is chatbots.messenger
       instances => [
          WebHook => [
             # Bot::ChatBots::Messenger::WebHook-specific parameters...
          ]
       ];
    app->start;

# DESCRIPTION

This module allows you to load a [Mojolicious](https://metacpan.org/pod/Mojolicious) plugin for dealing with
Facebook Messenger webhooks for a chatbot.

# METHODS

This module inherits from [Bot::ChatBots::MojoPlugin](https://metacpan.org/pod/Bot::ChatBots::MojoPlugin) and adds nothing.

# BUGS AND LIMITATIONS

Report bugs either through RT or GitHub (patches welcome).

# SEE ALSO

Foo::Bar.

# AUTHOR

Flavio Poletti <polettix@cpan.org>

# COPYRIGHT AND LICENSE

Copyright (C) 2016 by Flavio Poletti <polettix@cpan.org>

This module is free software. You can redistribute it and/or modify it
under the terms of the Artistic License 2.0.

This program is distributed in the hope that it will be useful, but
without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.
