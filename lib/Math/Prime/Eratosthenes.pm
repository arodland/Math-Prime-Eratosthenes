package Math::Prime::Eratosthenes;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT_OK = qw(gen_primes);

my (%witness, @primes);

sub gen_primes {
  my ($n, $prime_idx) = (2, 0);
  return sub {
    # Did someone else generate ahead of us?
    if (exists $primes[$prime_idx]) {
      # Then just return the next one available.
      $n = $primes[$prime_idx++];
      return $n++;
    }
    # Otherwise, generate a new prime.
    while (1) {
      # Is $n composite?
      if (my $p = delete $witness{$n}) {
        # Then advance the marker for whatever prime $n is a multiple of.
        my $x = $n + $p;
        $x += $p while $witness{$x};
        $witness{$x} = $p;
      } else { # It's prime.
        # 2n, 3n, 5n, ... are already taken care of by markers for 2, 3, 5, ...
        # so place a marker for n^2.
        $witness{$n * $n} = $n;
        # Add $n to the list for other generators to return quick
        push @primes, $n;
        # Advance our own iterator so we don't double-return this one
        $prime_idx = @primes;
        # And likewise advance $n;
        return $n++;
      }
      $n++;
    }
  }
}

__PACKAGE__
