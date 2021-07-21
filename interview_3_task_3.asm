# author: Yong Zi Ying
# This task is to translate the python code into MIPS program faithfully
# Interview 3 Task 3


		.globl get_minimum
		
		
		.data
str1:		.asciiz "The minimum element in this list is "
str2: 		.asciiz "\n"


		.text
# Caller
main:		# def main() -> None:
		# set $fp and make spcae for locals
		addi $fp, $sp, 0	# copy $sp into $fp
		
		# allocate local
		addi $sp, $sp, -8	# 2 locals = 8 bytes
		# temp = -8($fp)	# for return value (min_item)
		# my_list = -4($fp)
		
		# initialise local
		# my_list = [2, 4, -1]
		addi $v0, $0, 9		# allocate space
		addi $a0, $0, 16	# (3 * 4) + 4 = 16
		syscall
		sw $v0, -4($fp)		# my_list(-4($fp)) = address
		addi $t0, $0, 3		# length of array, $t0 = 3
		sw $t0, ($v0)		# the_list.length = 3 
		
		lw $t0, -4($fp)		# load my_list(-4($fp)) into $t0
		addi $t1, $0, 2		# $t1 = 2
		addi $t2, $0, 4		# $t2 = 4
		addi $t3, $0, -1	# $t3 = -1
		sw $t1, 4($t0)		# my_list[0] = 2 
		sw $t2, 8($t0)		# my_list[1] = 4
		sw $t3, 12($t0)		# my_list[2] = -1 
		
		# call get_minimum(the_list)
		# push 1 * 4 = 4 bytes of argument
		addi $sp, $sp, -4	# 1 argument = 4 bytes
		
		# argument = my_list = -4($fp)
		lw $t0, -4($fp)		# load my_list into $t0
		sw $t0, 0($sp)		# argument = my_list
		
		# link and goto get_minimum
		jal get_minimum
		
		
		# remove argument
		# pop 1 * 4 = 4 bytes of argument
		addi $sp, $sp, 4	# 1 argument = 4 bytes
		
		# store return value into temp
		addi $t0, $v0, 0	# $t0 = return value (min_item)
		sw $t0, -8($fp)		# store $t0 (min_item) into temp
		
		# print("The minimum element in this list is " + str(get_minimum(my_list)))
		# print str1
		la $a0, str1		# load address of str1 into $a0
		addi $v0, $0, 4		# set syscall to 4
		syscall			# print str1
		
		# print return value (min_item)
		lw $a0, -8($fp)		# load temp(return value = min_item) into $a0
		addi $v0, $0, 1		# set syscall into 1
		syscall 		# print min_item
		
		# print new line
        	la $a0, str2		# load address of str2 into $a0
		addi $v0, $0, 4		# set syscall to 4
		syscall			# print str2
		
		
		# exit program
exit:		addi $v0, $0, 10	# set syscall into 10
		syscall			# exit program
		
		
# Callee		
get_minimum:	# def get_minimum(the_list: List[int]) -> int:
		# save $ra and $fp in stack
		addi $sp, $sp, -8	# make space
		sw $ra, 4($sp)		# save $ra
		sw $fp, 0($sp)		# save $fp
		
		addi $fp, $sp, 0	# copy $sp into $fp
		
		# allocate local
		addi $sp, $sp, -12	# 3 locals = 12 bytes
		# min_item = -12($fp)
		# i = -8($fp)
		# item = -4($fp)
		# saved fp is at ($fp)
		# saved ra is at 4($fp)
		# the_list = 8($fp) [arg]
		
		# initialise local
		# min_item = the_list[0]
		lw $t0, 8($fp)		# load the_list into $t0
		lw $t1, 4($t0)		# $t1 = the_list[0] (4($t0))
		sw $t1, -12($fp)	# store the_list[0] into min_item
		
		
		# local variable i
		addi $t0, $0, 1		# $t0 = 1
		sw $t0, -8($fp)		# store $t0 into i, i = 1
		# for i in range(1, len(the_list)):
while_i_lt_len:		
		lw $t0, -8($fp)		# load i into $t0
		lw $t1, 8($fp)		# load the_list into $t1	
		lw $t2, ($t1)		# $t2 = len(the_list) 
		slt $t0, $t0, $t2	# is i($t0) < len(the_list) ($t2)  ? 
		beq $t0, $0, while_i_gt_len	# $t0 = 0, go to while_i_gt_len
		
		# item = the_list[i]
		lw $t0, -8($fp)		# load i into $t0
		lw $t1, 8($fp)		# load the_list into $t1
		sll $t0, $t0, 2		# $t0 = i($t0) * 4
       		add $t0, $t0, $t1	# $t0 = (the_list + (i * 4))	
		lw $t2, 4($t0)		# $t2 = the_list[i]
		sw $t2, -4($fp)		# store the_list[i] into item (-4($fp))
		
		
		# if min_item > item:
if_item_lt_min:
		lw $t0, -12($fp)	# load min_item into $t0
		lw $t1, -4($fp)		# load item into $t1
		slt $t2, $t1, $t0	# is item($t1) < min_item($t0) ?
		beq $t2, $0, increment	# $t2 = 0, go to increment
		
		# min_item = item
		lw $t0, -4($fp)		# load item into $t0
		sw $t0, -12($fp)	# store item into min_item (-12($fp))
		
		
		# i += 1
increment:	lw $t0, -8($fp)		# load i into $t0
		addi $t0, $t0, 1	# $t0 = 1
		sw $t0, -8($fp)		# i = i + 1

		# restart the loop
		j while_i_lt_len	# jump to while_i_lt_len	


while_i_gt_len:
		# return min_item
		lw $v0, -12($fp)	# return min_item in $v0
		
		# remove local 
		addi $sp, $sp, 12	# 3 locals = 12 bytes
		
		# restore $fp and $ra
		lw $fp, 0($sp)		# restore $fp
		lw $ra, 4($sp)		# restore $ra
		addi $sp, $sp, 8	# deallocate

		# return to caller
		jr $ra
