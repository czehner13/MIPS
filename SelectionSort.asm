.data
prompt: .asciiz "Input your name: \n"	# Prompt user for input
input: .asciiz "          "		# 10 character string
.text
.globl main

main:

	j userinput			# Call user 

userinput:
	la $a0, prompt			# Load prompt into address 0
	li $v0, 4			# Load string into opcode to write
	syscall				# Initialize system call for jump
	la $a0, input			# Load input into a0
	li $a1, 11			# Read in 10 characters to fill input string
	li $v0, 8			# Load string into opcode to read
	syscall
	
swap:
	sll $t1, $a1, 2 		# $t1 = k * 4
	add $t1, $a0, $t1 		# $t1 = v+(k*4)
	lw $t0, 0($t1)    		# $t0 (temp) = v[k]
	lw $t2, 4($t1)    		# $t2 = v[k+1]
	sw $t2, 0($t1)    		# v[k] = $t2 (v[k+1])
	sw $t0, 4($t1)    		# v[k+1] = $t0 (temp)
	jr $ra				# return to calling routine
	
sort:
	move $s2, $a0           	# save $a0 into $s2
	move $s3, $a1           	# save $a1 into $s3
	move $s0, $zero         	# i = 0
	
for1tst: 
	slt $t0, $s0, $s3      		# $t0 = 0 if $s0 ≥ $s3 (i ≥ n)
	beq $t0, $zero, exit1  		# go to exit1 if $s0 ≥ $s3 (i ≥ n)
	subi $s1, $s0, 1       		# j = i	– 1
	
for2tst: 
	slti $t0, $s1, 0        	# $t0 = 1 if $s1 < 0 (j < 0)
	bne $t0, $zero, exit2  		# go to exit2 if $s1 < 0 (j < 0)
	sll $t1, $s1, 2        		# $t1 = j * 4
	add $t2, $s2, $t1      		# $t2 = v + (j * 4)
	lw $t3, 0($t2)        		# $t3 = v[j]
	lw $t4, 4($t2)        		# $t4 = v[j + 1]
	slt $t0, $t4, $t3      		# $t0 = 0 if $t4 ≥ $t3
	beq $t0, $zero, exit2  		# go to exit2 if $t4 ≥ $t3
	move $a0, $s2   		# 1st param of swap is v (old $a0)
	move $a1, $s1           	# 2nd param of swap is j
	jal swap               		# call swap procedure
	
exit1:
	subi $s1, $s1, 1       		# j –= 1
	j    for2tst            	# jump to test of inner loop
	
exit2:   
	addi $s0, $s0, 1        	# i += 1
	j    for1tst            	# jump to test of outer loop
