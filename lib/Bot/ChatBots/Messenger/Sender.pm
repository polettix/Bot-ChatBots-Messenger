package Bot::ChatBots::Messenger::Sender;
use strict;
use warnings;
{ our $VERSION = '0.001002'; }

use Ouch;
use Log::Any qw< $log >;
use Mojo::URL;

use Moo;
use namespace::clean;

with 'Bot::ChatBots::Role::Sender';

has token => (
   is       => 'ro',
   required => 1,
);

has url => (
   is      => 'ro',
   default => 'https://graph.facebook.com/v2.6/me/messages',
);

has _url => (
   is      => 'ro',
   lazy    => 1,
   default => sub {
      my $self = shift;
      return Mojo::URL->new($self->url)
        ->query({access_token => $self->token});
   };
);

sub normalize_message {
   my ($self, $message, $record) = @_;

   $message = {message => {text => $message}} unless ref $message;

   if (! exists $message->{recipient}) {
      if (defined $record)) { # take from $record
         $message->{recipient} = {id => $record->{sender}{id}};
      }
      elsif ($self->has_recipient) {
         $message->{recipient} = {id => $self->recipient};
      }
      else { # no more ways to figure it out
         ouch 500, 'no recipient for message';
      }
   }

   return $message;
}

sub send_message {
   my $self    = shift;
   my $message = $self->normalize_message(@_);
   return $self->ua_request(
      post => $self->_url,
      {Accept => 'application/json'},
      json => $message,
   );
} ## end sub send_message

1;
