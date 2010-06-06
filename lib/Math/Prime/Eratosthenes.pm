package Math::Prime::Eratosthenes;
use strict;
use warnings;
# ABSTRACT: A Pure Perl Prime Generator using the Sieve of Eratosthenes
use Exporter 'import';
our @EXPORT_OK = qw(gen_primes);

# Bootstrap 2 onto the list so that the generator proper only needs to
# deal with odd primes.
my @primes = (2);
my %witness; # We don't need witnesses to 2 because we never check even numbers.

sub gen_primes {
  my ($n, $prime_idx) = (2, 0);
  return sub {
    # Did someone else generate ahead of us?
    if (exists $primes[$prime_idx]) {
      # Then just return the next one available.
      $n = $primes[$prime_idx++];
      return $n++;
    }
    # Otherwise, generate a new prime. $n is odd and greater than 2.
    while (1) {
      # Is $n composite?
      if (my $p = delete $witness{$n}) {
        # Then advance the marker for whatever prime $n is a multiple of.
        my $x = $n + 2*$p; # n,p are odd, so n+p would be even.
        $x += 2*$p while $witness{$x};
        $witness{$x} = $p;
      } else { # It's prime.
        # 3n, 5n, ... are already taken care of by markers for 3, 5, ...
        # so place a marker for n^2.
        $witness{$n * $n} = $n;
        # Add $n to the list for other generators to return quick
        push @primes, $n;
        # Advance our own iterator so we don't double-return this one
        $prime_idx = @primes;
        # And likewise advance $n;
        $n += 2;
        return $primes[-1];
      }
      $n += 2;
    }
  }
}

__PACKAGE__
