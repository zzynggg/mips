# author: Yong Zi Ying
# This task is to translate the python code into MIPS program faithfully
# Interview 3 Task 4


		.globl bubble_sort

		
		.data
space:		.asciiz " "
str1: 		.asciiz "\n"


		.text
# Caller
main:		# def main() -> None:
		# set $fp and make spcae for locals
		addi $fp, $sp, 0	# copy $sp into $fp
		
		#allocate local
		addi $sp, $sp, -8	# 2 locals = 8 bytes	
		# the_list = -8($fp)
		# i = -4($fp)
		
		# initialise local
		# the_list = [4, -2, 6, 7]
		addi $v0, $0, 9		# allocate space
		addi $a0, $0, 20	# (4 * 4) + 4 = 20
		syscall
		sw $v0, -8($fp)		# my_list(-8($fp)) = address
		addi $t0, $0, 4		# length of array, $t0 = 4
		sw $t0, ($v0)		# the_list.length = 4
		
		lw $t0, -8($fp)		# load my_list(-8($fp)) into $t0
		addi $t1, $0, 4		# $t1 = 4
		addi $t2, $0, -2	# $t2 = -2
		addi $t3, $0, 6		# $t3 = 6
		addi $t4, $0, 7		# $t4 = 7
		sw $t1, 4($t0)		# my_list[0] = 4
		sw $t2, 8($t0)		# my_list[1] = -2
		sw $t3, 12($t0)		# my_list[2] = 6
		sw $t4, 16($t0)		# my_list[3] = 7
		
		# call bubble_sort(the_list)
		# push 1 * 4 = 4 bytes of argument
		addi $sp, $sp, -4	# 1 argument = 4 bytes
		
		# argument = the_list = -8($fp)
		lw $t0, -8($fp)		# load the_list into $t0
		sw $t0, 0($sp)		# argument = the_list
		
		# link and goto bubble_sort
		jal bubble_sort
		
		
		# remove argument
		# pop 1 * 4 = 4 bytes of argument
		addi $sp, $sp, 4	# 1 argument = 4 bytes
		
		
		# local variable i
		sw $0, -4($fp)		# store 0 into i (-4($fp))
		# for i in range(len(the_list)):
while_i_lt_len:		
		lw $t0, -4($fp)		# load i into $t0
		lw $t1, -8($fp)		# load the_list into $t1
		lw $t2, ($t1)		# $t2 = len(the_list) 
		slt $t3, $t0, $t2	# is i($t0) < len(the_list)($t2) ?
		beq $t3, $0, while_i_gt_len	# $t3 = 0, go to while_i_gt_len
				
		# print(the_list[i], end='')
		lw $t0, -4($fp)		# load i into $t0
		lw $t1, -8($fp)		# load the_list into $t1
		sll $t0, $t0, 2		# $t0 = i * 4
       		add $t0, $t0, $t1	# $t0 = (the_list + (i * 4))	
		lw $a0, 4($t0)		# $a0 = the_list[i] 
		addi $v0, $0, 1		# set syscall into 1
		syscall			# print the_list[i]
		
		# print(' ', end='')
		# print space
		la $a0, space		# load address of space into $a0
		addi $v0, $0, 4		# set syscall into 4
		syscall			# print space
		
		
		# i += 1
increment:	lw $t0, -4($fp)		# load i into $t0
		addi $t0, $t0, 1	# $t0 = 1
		sw $t0, -4($fp)		# i = i + 1

		# restart the loop
		j while_i_lt_len	# jump to while_i_lt_len
		
		
while_i_gt_len:
		# print()
		# print new line
        	la $a0, str1		# load address of str1 into $a0
		addi $v0, $0, 4		# set syscall to 4
		syscall			# print str1
		
		# exit program
		addi $v0, $0, 10	# set syscall into 10
		syscall			# exit program
		
		
# Callee
bubble_sort:	# def bubble_sort(the_list: List[int]) -> None:
		# save $ra and $fp in stack
		addi $sp, $sp, -8	# make space
		sw $ra, 4($sp)		# save $ra
		sw $fp, 0($sp)		# save $fp
		
		addi $fp, $sp, 0	# copy $sp into $fp
		
		# allocate local
		addi $sp, $sp, -20	# 5 locals = 20 bytes
		# n		= -20($fp)
		# a		= -16($fp)
		# i		= -12($fp)
		# item		= -8($fp)
		# item_to_right	= -4($fp)
		# saved fp is at ($fp)
		# saved ra is at 4($fp)
		# the_list 	= 8($fp) [arg]
		
		# initialise local
		# n = len(the_list)
		## ERROR ##
		lw $t0, 8($fp)		# load the_list into $t0
		lw $t1, 0($t0)		# $t1 = len(the_list)
		sw $t1, -20($fp)	# store len(the_list) into n (-20($fp))


		sw $0, -16($fp)		# a = 0
		# for a in range(n-1):
while_a_lt_n:			
		lw $t0, -16($fp)	# load a into $t0
		lw $t1, -20($fp)	# load n into $t1
		addi $t2, $0, 1		# $t2 = 1
		sub $t1, $t1, $t2	# $t1 = n - 1
		slt $t3, $t0, $t1	# is a($t0) < n - 1 ($t1)?
		beq $t3, $0, while_a_gt_n	# $t3 = 0, go to while_a_gt_n
		
		sw $0, -12($fp)		# set/reset i = 0
		# for i in range(n-1):
while_i_lt_n:	
		lw $t0, -12($fp)	# load i into $t0
		lw $t1, -20($fp)	# load n into $t1
		addi $t2, $0, 1		# $t2 = 1
		sub $t1, $t1, $t2	# $t1 = n - 1
		slt $t3, $t0, $t1	# is i ($0) < n - 1 ($t1)?
		beq $t3, $0, counter_a_loop	# $t3 = 0, go to counter_a_loop

		# item = the_list[i]
		lw $t0, -12($fp)	# load i into $t0
		lw $t1, 8($fp)		# load the_list into $t1
		sll $t0, $t0, 2		# $t0 = i * 4
       		add $t0, $t0, $t1	# $t0 = (the_list + (i * 4))	
		lw $t2, 4($t0)		# $t2 = the_list[i]
		sw $t2, -8($fp)		# store the_list[i] into item (-8($fp))
		
		# item_to_right = the_list[i+1]
		lw $t0, -12($fp)	# load i into $t0
		lw $t1, 8($fp)		# load the_list into $t1
		addi $t0, $t0, 1	# $t0 = i + 1 
		sll $t0, $t0, 2		# $t0 = (i + 1) * 4
       		add $t0, $t0, $t1	# $t0 = (the_list + ((i + 1) * 4))	
		lw $t2, 4($t0)		# $t2 = the_list[i+1]
		sw $t2, -4($fp)		# store the_list[i+1] into item_to_right (-4($fp))
		
		
		# if item > item_to_right: 
if_item_to_right_lt_item:
		lw $t0, -8($fp)		# load item into $t0
		lw $t1, -4($fp)		# load item_to_right into $t1
		slt $t2, $t1, $t0	# is item_to_right($t1) < item($t0)?
		beq $t2, $0, counter_i_loop	# $t2 = 0, go to counter_i_loop
		
		# the_list[i] = item_to_right
		lw $t0, -12($fp)	# load i into $t0
		lw $t1, 8($fp)		# load the_list into $t1
		lw $t2, -4($fp)		# load item_to_right into $t2
		sll $t0, $t0, 2		# $t0 = i * 4
       		add $t0, $t0, $t1	# $t0 = (the_list + (i * 4))	
		sw $t2, 4($t0)		# store item_to_right into the_list[i] ($t2)
		
		# the_list[i+1] = item
		lw $t0, -12($fp)	# load i into $t0
		lw $t1, 8($fp)		# load the_list into $t1
		lw $t2, -8($fp)		# load item into $t2
		addi $t0, $t0, 1	# $t0 = i + 1 
		sll $t0, $t0, 2		# $t0 = (i + 1) * 4
       		add $t0, $t0, $t1	# $t0 = (the_list + ((i + 1) * 4))		
		sw $t2, 4($t0)		# store item into the_list[i+1] 
		
		
counter_i_loop:	# i += 1
		lw $t0, -12($fp)	# load i into $t0
		addi $t0, $t0, 1	# $t0 = 1
		sw $t0, -12($fp)	# i = i + 1

		# restart the i_loop
		j while_i_lt_n		# jump to while_i_lt_n	


counter_a_loop: # a += 1
		lw $t0, -16($fp)	# load a into $t0
		addi $t0, $t0, 1	# $t0 = 1
		sw $t0, -16($fp)	# a = a + 1

		# restart the a_loop
		j while_a_lt_n		# jump to while_a_lt_n


while_a_gt_n:	
		# remove local
		addi $sp, $sp, 20	# 5 locals = 20 bytes
		
		# restore $fp and $ra
		lw $fp, 0($sp)		# restore $fp
		lw $ra, 4($sp)		# restore $ra
		addi $sp, $sp, 8	# deallocate

		# return to caller
		jr $ra
