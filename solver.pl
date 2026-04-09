use strict;

my $WORD_LIST_PATH = '/usr/share/dict/words'; 
my @CLUE_WORD_LIST = ();   # The list of clue words
my @REGEX_LIST = ();       # The list of clue words converted to regex for search
my @GUESS_INDEX = ();      # The index of the missing letter in each word

sub find_clue_word_matches {
  my ($regex, $ra) = @_;

  my @matches = grep { /$regex/ } @$ra;

  for my $match (@matches) {
    print "$match\n";
  }
}


sub generate_search_regex {
  # This is the regex comprised of all the clue word matches that is used to query the result:
  my $ra = shift;
  my $counter = 0;
  my $regex = '^';

  # This section creates a regex for the entire keyword.
  # For these clues: sn_p, _erby, _eel, pe_, ste_n, g_ntly
  # the resultant regex will look like this:
  # ^[ai][d][fhkpr][aegnprtw][ir][e]$
  #
  foreach $regex (@REGEX_LIST) {
    my $clue_word = $CLUE_WORD_LIST[$counter];
    my $idx = index($clue_word, '_');
    my @matches = find_clue_word_matches($regex, $ra);
    chomp(@matches);  # ?necessary
    my $match = '';
    my $match_text = join(',', @matches);
    print("Matches for $regex: $match_text\n"); 

#    my $character_class = '[';
#    foreach $match (@matches) {
#      my $character = substr($match, $idx, 1);
#      $character_class .= $character;
#    }
#    $character_class .= ']';
#    $regex .= $character_class;
    $counter++;
  }

  $regex .= '$';

  return $regex;
}


sub load_guess_index_list() {
  my $clueWord = '';
  my $idx = 0;

  foreach $clueWord (@CLUE_WORD_LIST) {
    $idx = index($clueWord, '_');
    if ($idx > -1 ) {
      print("The guess index for $clueWord is $idx\n");
      push(@GUESS_INDEX, $idx);
    } else {
      print("$clueWord has no underscore\n");
      exit(1);
    }
  }
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
    print("Clue word $clueWord becomes regex $regex\n");
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
  @CLUE_WORD_LIST = @ARGV;
}

my $nClueWords = scalar(@CLUE_WORD_LIST);
my $clueWord = '';

if ($nClueWords != 6) {
  usage();
  exit(1);
} else {
  foreach $clueWord (@CLUE_WORD_LIST) {
    print "$clueWord\n"
  }
  print("\n");
}

load_guess_index_list();
load_regex_list();

open(SRC, "<$WORD_LIST_PATH") or die "Cannot open $WORD_LIST_PATH (read-only)" ;
my @lines = <SRC>;
close(SRC);
chomp(@lines);

my $regex = generate_search_regex(\@lines);
print("search regex: $regex\n");

# my @test_list = qw(Amanda ban can fan man mancave pan plan ran tan than van wan); 
#find_clue_word_matches '^[a-z]an$', \@lines;   # ban can fan man pan ran tan van wan 
#find_clue_word_matches '^[a-z]oney$', \@lines;
#find_clue_word_matches '^c[a-z]lon$', \@lines;
#find_clue_word_matches '^w[a-z]nder$', \@lines;


