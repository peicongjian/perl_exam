#************************************************************************#
#Question:
#Given two words (start and end), and a dictionary, find all shortest 
#transformation sequence(s) from start to end, such that:
#
#Only one letter can be changed at a time
#Each intermediate word must exist in the dictionary
#
#For example,
#
#Given:
#start = "hit"
#end = "cog"
#dict = ["hot","dot","dog","lot","log"]
#Return
#  [
#    ["hit","hot","dot","dog","cog"],
#    ["hit","hot","lot","log","cog"]
#  ]

#******本题目考察层序遍历，与利用合适的数据结构记录想要的结果的能力******#
our $START = "hit";
our $END = "cog";
our $DICT = ["hot","dot","dog","lot","log",];

#--------------计算最短路径，并打印每种路径-------------
our %path_tree ;
my @start_array = ($START);
my $len = 2 + &construct_shortest_path (\@start_array,$DICT,0); #起始为0层。
print "shortest path length is $len\n\n"; 
&print_shortest_path($END);

#---------返回最短路径的长度(首尾不算入)。
sub construct_shortest_path()
{
	my ($start_array, $dict, $layer) = @_;
	my @valid_dict = @{$dict};
	my @start = @{$start_array};
	
	#找出所有符合条件的一层,
	my @next_layer;
	foreach my $start_word (@start) {
		foreach my $dict_word(@valid_dict) {
			if (&diff($dict_word,$start_word)) {
				push @{$path_tree{$dict_word}}, $start_word; #记录路径
				push @next_layer,$dict_word;
			}
		}
	}
	
	if (@next_layer) {#一层非空，则层数加1.
		$layer ++;
	} 
	else {#说明字典里没有下层字母了，即走到死胡同了。
		die "there's no such word ladder\n";
	}
	
	#比较这一层里与最终结果是否差一个字母
	my $find_flag = 0;
	foreach (@next_layer) {
		if (&diff($_,$END)) {
			$find_flag = 1;
			push @{$path_tree{$END}}, $_;	#记录路径	
		}
	}
	
	if ($find_flag) {
		return $layer;   #返回层数
	}
	else { #这一层里都不符合
		#将字典里删掉这一层的字母。并以这一层字母为起始点，继续去找下一层的字母。
		&del_array(\@valid_dict,\@next_layer);
		&construct_shortest_path(\@next_layer, \@valid_dict, $layer);
	}	
}


#----------打印所有的最短路径。
sub print_shortest_path ()
{
	my ($last_word,$path) = @_;
	defined $path or $path = [];
	
	if (exists $path_tree{$last_word}) { 
		foreach (@{$path_tree{$last_word}}) {
			push @{$path}, $last_word;
			&print_shortest_path ($_,$path);
		}		
	}
	else { #找到起始点了。
		push @{$path}, $START;
		my @find_path = reverse @{$path};
		print "@find_path\n";
		@{$path} = (); #重置路径。	
	}
}

#--------diff 判断两个变量是否相差一个字母,是则返回真，否则返回假。
sub diff()
{
	my ($a,$b) = @_;
	my @char_a = split ("",$a);
	my @char_b = split ("",$b);
	my $len = @char_a;
	my $diff = 0;
	foreach (0..$len-1) {
		if ($char_a[$_] ne $char_b[$_]) {
			$diff +=1;
		}
	} 
	return ($diff == 1) ? 1 : 0;
}

#-----------del_array 输入两个数组，在前一个数组中删掉后一个数组中出现的元素
sub del_array ()
{
	my ($a,$b) = @_;
	foreach my $element (@{$b}) {
		my $index = 0;
		foreach (@{$a}) {
			if ($_ eq $element) {
				splice (@{$a},$index,1); #删除数组元素 
			}
			$index ++;
		}
	}
}
#END
