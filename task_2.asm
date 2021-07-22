# author: Yong Zi Ying
# This task is to translate the python code into MIPS program faithfully
# Task 2
# Grade: 20/20 HD


		.data
i:		.word 0
size:		.word 0
the_list:	.word 0
min_item:	.word 0
str1:		.asciiz "Array length: "
str2:		.asciiz "Enter num: "
str3:		.asciiz "The minimum element in this list is "
str4:		.asciiz "\n"


		.text
main:		# size = int(input("Array length: "))
		# print size
		la $a0, str1		# load address of str1 into $a0
		addi $v0, $0, 4		# set syscall to 4
		syscall			# print str1
	
		# allow user to input size
		addi $v0, $0, 5		# set syscall to 5
		syscall			# read integer
		sw $v0, size		# let size = the integer read in

		# the_list = [None] * size
		addi $v0, $0, 9		# allocate
		lw $t0, size		# load size into $t0
		sll $t1, $t0, 2		# $t1 = size($t0) * 4
		addi $a0, $t1, 4	# $a0 = (size * 4) + 4
		syscall			
		sw $v0, the_list	# the_list = address
		sw $t0, ($v0)		# the_list.length = size	
		
	
		# for i in range(len(the_list)):
		# while i < len(the_list)
while_i_lt_size:
		lw $t0, i			# load i into $t0
		lw $t1, the_list		# load the_list into $t1
		lw $t2, ($t1)			# $t2 = len(the_list) 
		slt $t0, $t0, $t2		# is i($t0) < (len(the_list)) ($t2)?
		beq $t0, $0, while_i_gt_size	# $t0 = 0, go to while_i_gt_size
			
		# the_list[i] = int(input("Enter num: "))
		# print str2
		la $a0, str2		# load address of str2 into $a0
		addi $v0, $0, 4		# set syscall to 4
		syscall			# print str2
		
		# the_list[i]
		lw $t0, i		# load i into $t0
		lw $t1, the_list	# load the_list into $t1
		sll $t0, $t0, 2		# $t0 = i($t0) * 4
		add $t0, $t0, $t1	# $t0 = ((i * 4) + the_list)
		addi $v0, $0, 5		# set syscall to 5
		syscall 		# read num
		sw $v0, 4($t0)		# the_list[i] = num
		
		
    		# if i == 0 or min_item > the_list[i]:
if_i_eq_zero_or_the_list_i_lt_min_item:
    		# check i == 0
       		lw $t0, i		# load i into $t0
       		beq $t0, $0, i_eq_0	# $t0 = 0, go to i_eq_0  
       
		# $t0 != 0 [OR] [False]
		# check min_item > the_list[i]
       		lw $t0, the_list	# load the_list into $t0
       		lw $t1, i		# load i into $t1
       		lw $t2, min_item	# load min_item into $t2
       		sll $t3, $t1, 2		# $t3 = i($t1) * 4
       		add $t0, $t0, $t3	# $t0 = (the_list + (i * 4)) 
       		lw $t4, 4($t0)		# $t4 = the_list[i]
       		slt $t5, $t4, $t2	# is (the_list[i]) ($t4) < min_item ($t2) ?
       		beq $t5, $0, increment	# $t5 = 0, go to increment 
       		
       		
       		#  min_item = the_list[i]
i_eq_0:		lw $t0, i		# load i into $t0
		lw $t1, the_list	# load the_list into $t1
		sll $t0, $t0, 2		# $t0 = i($t0) * 4
		add $t0, $t0, $t1	# $t0 = ((i * 4) + the_list)
		lw $t2, 4($t0)		# $t2 = the_list[i]
		sw $t2, min_item	# store the_list[i] into min_item
	
	
		# i += 1
increment:	lw $t0, i		# load i into $t0
		addi $t0, $t0, 1	# $t0 = 1
		sw $t0, i		# i = i + 1

		# restart the loop
		j while_i_lt_size	# jump to while_i_lt_size
		

while_i_gt_size:# print("The minimum element in this list is " + str(min_item))
		# print str3
		la $a0, str3		# load address of str3 into $a0
		addi $v0, $0, 4		# set syscall to 4
		syscall			# print str3
		
		lw $a0, min_item	# load min_item into $a0
		addi $v0, $0, 1		# set syscall to 1
		syscall			# print min_item
		
		# print new line
        	la $a0, str4		# load address of str4 into $a0
		addi $v0, $0, 4		# set syscall to 4
		syscall			# print str4
		
		
exit:		#exit program
	  	addi $v0, $0, 10	# set syscall to 10
	 	syscall 		# exit program
  
		
		
		
		
