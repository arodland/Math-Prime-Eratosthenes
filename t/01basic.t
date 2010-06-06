#!perl
use strict;
use warnings;

use Test::More;

BEGIN { 
  use_ok 'Math::Prime::Eratosthenes' => qw(gen_primes);
}

my $gen1 = gen_primes;
my $gen2 = gen_primes;

my @first5 = map $gen1->(), 1..5;
is_deeply \@first5, [ 2, 3, 5, 7, 11 ], "first five primes, first gen";

my @first5again = map $gen2->(), 1..5;
is_deeply \@first5again, [ 2, 3, 5, 7, 11 ], "first five primes, second gen";

my @next3 = map $gen1->(), 1..3;
is_deeply \@next3, [ 13, 17, 19 ], "next three, first gen";

done_testing;
