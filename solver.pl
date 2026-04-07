use strict;

my $WORD_LIST_PATH = '/usr/share/dict/words'; 
my @CLUE_WORD_LIST = (); 


sub find_clue_word_matches {
  my ($regex, $ra) = @_;

  my @matches = grep { /$regex/ } @$ra;

  for my $match (@matches) {
    print "$match\n";
  }
}

sub usage() {
  print("This solves the keyword puzzle in the Washington Post.\n");
  print("Arguments:\n");
  print("The keyword clues in order, with blank spaces replaced by underscores\n");
}





#---main-----------------------------------------------------------------------
# usage();

open(SRC, "<$WORD_LIST_PATH") or die "Cannot open $WORD_LIST_PATH (read-only)" ;
my @lines = <SRC>;
close(SRC);
chomp(@lines);

# my @test_list = qw(Amanda ban can fan man mancave pan plan ran tan than van wan); 
find_clue_word_matches '^[a-z]an$', \@lines;   # ban can fan man pan ran tan van wan 
find_clue_word_matches '^[a-z]oney$', \@lines;
find_clue_word_matches '^c[a-z]lon$', \@lines;
find_clue_word_matches '^w[a-z]nder$', \@lines;


