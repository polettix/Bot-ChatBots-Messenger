package Bot::ChatBots::Messenger::Sender;
use strict;
use warnings;
{ our $VERSION = '0.001005'; }

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
   my ($self, $message, %args) = @_;
   ouch 500, 'no output to send' unless defined $message;

   # message normalization
   $message = {message => {text => $message}} unless ref $message;
   if (! exists $message->{recipient}) {
      if (defined $args{record}) { # take from record
         $message->{recipient}{id} = $args{record}{channel}{id};
      }
      elsif ($self->has_recipient) {
         $message->{recipient}{id} = $self->recipient;
      }
      else { # no more ways to figure it out
         ouch 500, 'no recipient for message';
      }
   }

   return $self->ua_request(
      'post',
      %args,
      ua_args => [
         $self->_url,
         {Accept => 'application/json'},
         json => $message,
         ($args{callback} ? $args{callback} : ()),
      ],
   );
} ## end sub send_message

1;
