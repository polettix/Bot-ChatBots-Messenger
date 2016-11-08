package Bot::ChatBots::Messenger::WebHook;
use strict;
use warnings;
{ our $VERSION = '0.001001'; }

use Ouch;
use Log::Any qw< $log >;
use Data::Dumper;

use Moo;
use namespace::clean;

with 'Bot::ChatBots::Role::WebHook';

sub normalize_record {
   my ($self, $record) = @_;
   my $update = $record->{update} or ouch 500, 'no update found!';

   $record->{source}{technology} = 'messenger';

   $record->{type} = 'message';
   $record->{payload} = $record->{update}{message};

   $record->{sender} = $record->{update}{sender};

   my $chan = $record->{channel} = {%{$record->{update}{recipient}}};
   $chan->{fqid} = $chan->{id};

   return $record;
}

sub parse_request {
   my ($self, $req) = @_;

   my $data = $req->json;
   return unless $data->{object} eq 'page';

   local $Data::Dumper::Indent = 1;
   my @updates;
   for my $entry (@{$data->{entry}}) {
      my $page_id    = $entry->{id};
      my $event_time = $entry->{time};

      EVENT:
      for my $event (@{$entry->{messaging}}) {
         if (exists $event->{message}) {
            push @updates, $event;
         }
         else {
            $log->warn('unknown event: ' . Dumper($event));
         }
      } ## end for my $event (@{$entry...})
   } ## end for my $entry (@{$data->...})

   return @updates;
} ## end sub parse_request

1;
