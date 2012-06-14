use strict;
use 5.10.0;
use WebService::Tumblr;
use Data::Dumper;

usage() unless $ENV{TUMBLR_NAME};
usage() unless $ENV{TUMBLR_EMAIL};
usage() unless $ENV{TUMBLR_PASSWORD};
usage() unless (-r $ARGV[0]);

# Parse the input file 
my (%params, $headers_complete);
{ 
   open my $in, '<', $ARGV[0];
   while (<$in>) {
      my $line = $_;
      if ($headers_complete) {
         $params{body} .= $line;
      } elsif ($line =~ /: /) {
         chomp $line;
         my ($key, $value) = split /: /, $line;
         if ($value =~ /,/) {
            $params{$key} = [ split /, /, $value ];
         } else {
            $params{$key} = $value;
         }
      } else {
         $headers_complete = 1;
      }
   }
}

# Post
my $tumblr = WebService::Tumblr->new(
   name     => $ENV{TUMBLR_NAME},
   email    => $ENV{TUMBLR_EMAIL},
   password => $ENV{TUMBLR_PASSWORD},
);
$params{type}   ||= 'regular';
$params{format} ||= 'markdown',
my $line = '-' x 30 . "\n";
say "$line Params\n '-' x 30 . "\n" . Dumper(%params) . 
my $dispatch = $tumblr->write(%params);
say $dispatch->result->request->as_string;
say $dispatch->result->response->as_string;

if ( $dispatch->is_success ) {
   my $post_id = $dispatch->content;
   say "Success! [$post_id]";
} else {
   say "FAILED! " . $dispatch->response->decoded_content;
}


sub usage {
   print <<'EOT';

$ export TUMBLR_NAME=...
$ export TUMBLR_EMAIL=...
$ export TUMBLR_PASSWORD=...
$ tumblr.pl new/2012061301.md

   Posts the Markdown text of 2012061301.md to Tumblr.

EOT
   exit;
}



