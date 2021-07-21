# author: Yong Zi Ying
# This task is to translate the python code into MIPS program faithfully
# Interview 3 Task 1
		
										
	.data
first:	.word 0
second:	.word 0
result:	.word 0
str1:	.asciiz "Enter first: "
str2:	.asciiz "Enter second: "
str3:	.asciiz "Result: "
str4:   .asciiz "\n"


	.text
main:	# first = int(input("Enter first: "))
	# print str1
	la $a0, str1		# load address of str1 into $a0
	addi $v0, $0, 4		# set syscall to 4
	syscall			# print str1
	
	# allow user input first
	addi $v0, $0, 5		# set syscall to 5
	syscall			# read first
	sw $v0, first		# let first = the integer read in
	
	# second = int(input("Enter second: "))
	# print str2
	la $a0, str2		# load address of str2 into $a0
	addi $v0, $0, 4		# set syscall to 4
	syscall			# print str2
	
	# allow user input second
	addi $v0, $0, 5		# set syscall to 5
	syscall			# read second
	sw $v0, second		# let second = the integer read in


	# if first > 0 and second >= 0:
if_zero_lt_first_and_second_gt_eq_zero:
	lw $t0, first		# load first into $t0
	lw $t1, second		# load second into $t1
	addi $t2, $0, 0		# $t2 = 0
	slt $t3, $t2, $t0	# is 0($t2) < first($t0) ? 
	beq $t3, $0, false_cond_go_elif	# if $t3 = 0, go to false_cond_go_elif [False] 
	slt $t4, $t1, $t2	# is second($t1) < 0($t2) ?  negate 0 = True; 1 = False
	bne $t4, $0, false_cond_go_elif	# if $t4 = 1, go to false_cond_go_elif [False]
	
	# if $t4 = $t5 = 1 [True]
	# result = second // first
	lw $t0, first		# load first into $t0
	lw $t1, second		# load second into $t1
	div $t1, $t0		# $a0 [quotient] = second ($t1) // first($t0)
	mflo $a0		# move quotient from LO to $a0
	sw $a0, result 		# store $a0 into result
	j endif_print_result	# jump to endif_print_result [skip elif and else] 


	# elif first == second or first < second: 
false_cond_go_elif:		# [elif]
	lw $t0, first		# load first into $t0
	lw $t1, second		# load second into $t1
	beq $t0, $t1, first_cond_True_continue	# first($t0) = second($t1) = True, go to first_cond_True_continue [skip second condition] [then]

	# first != second [OR]
	lw $t0, first		# load first into $t0
	lw $t1, second		# load second into $t1
	slt $t2, $t0, $t1	# is first($t0) < second($t1) ?
	beq $t2, $0, both_cond_False_go_else	# $t2 = False, go to both_cond_False_go_else 


	# if True for either first == second or first < second
	# result = first * second
first_cond_True_continue:	# [then]
	lw $t0, first		# load first into $t0
	lw $t1, second		# load second into $t1
	mult $t0, $t1		# $a0 = first($t0) * second($t1)
	mflo $a0		# move result from LO into $a0
	sw $a0, result		# store $a0 into result
	j endif_print_result	# jump to endif_print_result [skip else] 


	# else 
	# result = second * 2
both_cond_False_go_else:	# [else]
	lw $t0, second		# load second into $t0
   	addi $t1, $0, 2		# $t1 = 2
   	mult $t0, $t1		# $a0 = second($t0) * 2($t1)
   	mflo $a0		# move result from LO into $a0
   	sw $a0, result		# store $a0 into result
   	
   	
	# print("Result: " + str(result))
endif_print_result:	
	# print str3
	la $a0, str3		# load address of str3 into $a0
	addi $v0, $0, 4		# set syscall to 4
	syscall			# print str3
	
	# print result
	lw $a0, result		# load result into $a0
	addi $v0, $0, 1		# set syscall to 1
	syscall			# print result 
	
	# print new line
        la $a0, str4		# load address of str4 into $a0
	addi $v0, $0, 4		# set syscall to 4
	syscall			# print str4
	
	
exit:	# exit program 
	addi $v0, $0, 10	# set syscall to 10
	syscall 		# exit program
	
