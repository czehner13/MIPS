
.data
prompt: .asciiz "Input your name: \n"	# Prompt user for input
input: .asciiz "          "		# 10 character string
.text
.globl main

main:

	j userinput			# Call user 

userinput:
	la $a0, prompt			# Load prompt into address 0
	li $v0, 4			# Load string into opcode by
	syscall				# Initialize system call for jump
