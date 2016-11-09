package Bot::ChatBots::Messenger::Sender;
use strict;
use warnings;
{ our $VERSION = '0.001004'; }

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
   },
);

sub send_message {
   my ($self, $message) = splice @_, 0, 2;
   ouch 500, 'send_message: too many input arguments' if @_ > 2;

   my ($record, @callback);
   for (@_) {
      next unless defined $_;
      if (ref($_) eq 'CODE') {
         ouch 500, 'cannot set multiple callbacks' if @callback > 0;
         push @callback, $_;
      }
      else {
         ouch 500, 'cannot set multiple input records' if defined $record;
         $record = $_;
      }
   }

   # message normalization
   $message = {message => {text => $message}} unless ref $message;
   if (! exists $message->{recipient}) {
      if (defined $record) { # take from $record
         $message->{recipient} = {id => $record->{sender}{id}};
      }
      elsif ($self->has_recipient) {
         $message->{recipient} = {id => $self->recipient};
      }
      else { # no more ways to figure it out
         ouch 500, 'no recipient for message';
      }
   }

   return $self->ua_request(
      post => $self->_url,
      {Accept => 'application/json'},
      json => $message,
      @callback
   );
} ## end sub send_message

1;
