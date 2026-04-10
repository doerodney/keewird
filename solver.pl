use strict;

my $WORD_LIST_PATH = '/usr/share/dict/words'; 
my @CLUE_WORD_LIST = ();   # The list of clue words
my @REGEX_LIST = ();       # The list of clue words converted to regex for search


sub find_clue_word_matches {
  my ($regex, $ra) = @_;

  my @matches = grep { /$regex/ } @$ra;

  for my $match (@matches) {
    print "$match\n";
  }
}


sub generate_search_regex {
  # This returns the regex comprised of all the clue word matches that is used to query the result:
  my $ra = shift;
  my $counter = 0;
  my $regex = '';
  my $result = '^';

  # This section creates a regex for the entire keyword.
  # For these clues: sn_p, _erby, _eel, pe_, ste_n, g_ntly
  # the resultant regex will look like this:
  # ^[ai][d][fhkpr][aegnprtw][ir][e]$
  #
  foreach $regex (@REGEX_LIST) {
    my $clue = $CLUE_WORD_LIST[$counter];
    my $idx = index($clue, '_');
    my @words = grep { /$regex/ } @$ra;
    my $word = '';
    my $text = join(',', @words);
    print("Matches for $regex: $text\n"); 

    my @chars;
    my $class = '[';
    foreach $word (@words) {
      my $char = substr($word, $idx, 1);
      $class .= $char;
    }
    $class .= ']';
    $result .= $class;
    $counter++;
  }

  $result .= '$';

  return $result;
}


sub load_regex_list() {
  my $clueWord = '';
  my $idx = 0;
  my $regex = '';
  my $substr = '[a-z]';

  for ($idx = 0; $idx < 6; $idx++) {
    $clueWord = $CLUE_WORD_LIST[$idx];
    $regex = '^' . $clueWord;
    $regex .= '$';
    $regex =~ s/_/$substr/;
    push(@REGEX_LIST, $regex);
  }
}



sub usage() {
  print("This solves the keyword puzzle in the Washington Post.\n");
  print("Arguments:\n");
  print("Enter the keyword clues in order, spearated by spaces, with unknown letters (blanks) replaced by underscores\n");
}


#---main-----------------------------------------------------------------------
# Test: snap, derby, heel, pee, stern, gently are used to spell adhere
my @TEST_CLUE_WORD_LIST = qw(sn_p  _erby  _eel  pe_  ste_n  g_ntly);

my $nArgs = scalar(@ARGV);

if ($nArgs != 6) {
  @CLUE_WORD_LIST = @TEST_CLUE_WORD_LIST;
} else {
  for (my $i = 0; $i < 6; $i++) {
    push(@CLUE_WORD_LIST,  lc($ARGV[$i]));
  }
}

my $nClueWords = scalar(@CLUE_WORD_LIST);
my $clueWord = '';

if ($nClueWords != 6) {
  usage();
  exit(1);
} 

load_regex_list();

open(SRC, "<$WORD_LIST_PATH") or die "Cannot open $WORD_LIST_PATH (read-only)" ;
my @lines = <SRC>;
close(SRC);
chomp(@lines);

my $regex = generate_search_regex(\@lines);
print("search regex: $regex\n");
my @solutions = grep { /$regex/ } @lines;
my $solution;
foreach $solution (@solutions) {
  print("Solution: $solution\n");
}

# my @test_list = qw(Amanda ban can fan man mancave pan plan ran tan than van wan); 
#find_clue_word_matches '^[a-z]an$', \@lines;   # ban can fan man pan ran tan van wan 
#find_clue_word_matches '^[a-z]oney$', \@lines;
#find_clue_word_matches '^c[a-z]lon$', \@lines;
#find_clue_word_matches '^w[a-z]nder$', \@lines;


