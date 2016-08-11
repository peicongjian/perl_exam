#******************************************************#
#Questions:
#Transfer all 'O' surrounded by 'X' to be 'X', but leave
#other 'O'.
#For example
#Input is:
# X X X X
# X O O X
# X X O X
# X O X X
#Output shoulde be :
# X X X X
# X X X X
# X X X X
# X O X X

#*****本题目的：了解perl的二元数组，递归函数等用法*****#
#思路： 沿着方阵四条边遍历一圈，标记出所有'O'，以及与之相邻的'O',剩下的'O'就是被'X'包围的.
my $row = 4;
my $col = 4;
my $ini_board = [	['X','X','X','X'],
	            	['X','O','O','X'],
	            	['X','X','O','X'],
	                ['X','O','X','X'] ];
print "init board is :\n\n";
&board_print($ini_board,$row,$col); 

my $after_board = &transfer_board($ini_board,$row,$col);				 	
print "after board is :\n";
&board_print($after_board,$row,$col); 

#----------board print-----------#
sub board_print() 
{
	my ($board,$row_max,$col_max) = @_;
	
	foreach my $row(0..$row_max-1) {
		foreach my $col(0..$col_max-1) {
			print "$board->[$row]->[$col] ";
		}
		print "\n";
	}	
}

#----------transfer board-----------#
sub transfer_board() 
{
	my ($board,$row_max,$col_max) = @_;
	# check above line
	foreach (0..$col_max-1) {
		my $row = 0;
		if ($board->[$row]->[$_] eq 'O') {
			$board->[$row]->[$_] = '*'; # '*' represent 'O' not surrounded by 'X'.
			$board = &check_connect_point($board,$row,$_,$row_max,$col_max); #mark all the 'O' which connect with the above one.
		}
	}
	#check bottom line
	foreach (0..$col_max-1) {
		my $row = $row_max - 1;
		if ($board->[$row]->[$_] eq 'O') {
			$board->[$row]->[$_] = '*'; # '*' represent 'O' not surrounded by 'X'.
			$board = &check_connect_point($board,$row,$_,$row_max,$col_max); #mark all the 'O' which connect with the above one.
		}
	}
	#check left line
	foreach (0..$row_max-1) {
		my $col = 0;
		if ($board->[$_]->[$col] eq 'O') {
			$board->[$_]->[$col] = '*'; # '*' represent 'O' not surrounded by 'X'.
			$board = &check_connect_point($board,$_,$col,$row_max,$col_max); #mark all the 'O' which connect with the above one.
		}
	}
	#check right line
	foreach (0..$row_max-1) {
		my $col = $col_max - 1;
		if ($board->[$_]->[$col] eq 'O') {
			$board->[$_]->[$col] = '*'; # '*' represent 'O' not surrounded by 'X'.
			$board = &check_connect_point($board,$_,$col,$row_max,$col_max); #mark all the 'O' which connect with the above one.
		}
	}
	
	#replace surrunded 'O' with 'X', replace '*' with 'O'
	foreach my $row (0..$row_max-1) {
		foreach my $col (0..$col_max-1) {
			if ($board->[$row]->[$col] eq 'O') {
				$board->[$row]->[$col] = 'X';
			}
			if ($board->[$row]->[$col] eq '*') {
				$board->[$row]->[$col] = 'O';
			}
		}
	}
	
	#return board after transfer
	return $board;
}

#-----------------check_connect_point---------------#
#Tag all 'O' connect with the base point.
sub check_connect_point()
{
	my ($board,$row,$col,$row_max,$col_max) = @_;
	#base point is $row, $col.
	if (($row - 1 >= 0) && ($board->[$row-1]->[$col] eq 'O' )){
		$board->[$row-1]->[$col] = '*';
		$board = &check_connect_point($board,$row-1,$col,$row_max,$col_max);
	}
	
	if (($row + 1 < $row_max) && ($board->[$row+1]->[$col] eq 'O' )){
		$board->[$row+1]->[$col] = '*';
		$board = &check_connect_point($board,$row+1,$col,$row_max,$col_max);
	} 
	
	if (($col - 1 >= 0) && ($board->[$row]->[$col-1] eq 'O' )){
		$board->[$row]->[$col-1] = '*';
		$board = &check_connect_point($board,$row,$col-1,$row_max,$col_max);
	}
	
	if (($col + 1 < $col_max) && ($board->[$row]->[$col+1] eq 'O' )){
		$board->[$row]->[$col+1] = '*';
		$board = &check_connect_point($board,$row,$col+1,$row_max,$col_max);
	}
	
	return $board; 
}
#END				 
