#!/usr/bin/perl

use strict;
use warnings;

use Math::Prime::Eratosthenes qw(gen_primes);

my ($row_gen, $tick_gen) = (gen_primes, gen_primes);

my $n = 1;
my $next_prime = $tick_gen->();

while (1) {
  my $row_len = $row_gen->();
  for (1 .. $row_len) {
    if ($n == $next_prime) {
      print "#";
      $next_prime = $tick_gen->();
    } else {
      print ".";
    }
    $n++;
  }
  print "\n";
  last if $n > 1000;
}
