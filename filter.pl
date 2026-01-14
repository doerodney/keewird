use strict;

sub binary_search {
  my ($str, $ra) = @_;

  my $min = 0;
  my $max = scalar(@$ra) - 1;

  while ($min <= $max) {
    my $mid = int(($max + $min) / 2);
    if ($str eq $ra->[$mid]) {
      return $mid;
    }

    if ($str lt $ra->[$mid]) {
      $max = $mid - 1;
      next;
    }

    if ($str gt $ra->[$mid]) {
      $min = $mid + 1;
    }
  }

  return -1;
}


sub filter_word_length {
  my ($srcPath, $destPath) = @_;

  open(SRC, "<$srcPath") or die "Cannot read from $srcPath";
  my @srcLines = <SRC>;
  chomp(@srcLines);
  close(SRC);

  my $nSrcLines = scalar(@srcLines);
  print "$nSrcLines source lines detected";

  open(DEST, ">$destPath") or die "Cannot write to $destPath";

  foreach my $srcLine (@srcLines) {
    my $len = length($srcLine);
    if (($len >= 3) && ($len <= 6)) {
      print DEST "$srcLine\n";
    }
  }

  close(DEST);

}


sub testBinSearch {

  my @planets = qw( 
  earth
  jupiter
  mars
  mercury
  neptune
  saturn
  uranus
  venus
  );

  my @moons = qw(demos europa luna phobos);

  foreach my $planet (@planets) {
    my $idx = binary_search($planet, \@planets);
    if ($idx >= 0) {
      print "$planet is in index $idx\n";
    } else {
      print "$planet is not in list \n";
    }
  }

  foreach my $moon (@moons) {
    my $idx = binary_search($moon, \@planets);
    if ($idx >= 0) {
      print "$moon is in index $idx\n";
    } else {
      print "$moon is not in list \n";
    }
  }
}

#---main-----------------------------------------------------------------------

my $wordListPath = '/usr/share/dict/words';
my $stageLengthResultPath = 'stage-length-out.txt';

# Filter for word length:
filter_word_length($wordListPath, $stageLengthResultPath);


