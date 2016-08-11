#************************************************************#
#Question:
#Get a string from STDIN, and print its reverse to screen.
#For example, input is "my head is pain".
#Your script should print "pain is head my". 
#***********本题目的：锻炼perl的字符串操作。*****************#
print "please input a word string :\n";
my $input = <>;
chomp ($input);
my @output = reverse split(" ",$input);
print "reverse word string is:\n@output\n";
#END
