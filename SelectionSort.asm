
.data
prompt: .asciiz "Input your name: \n"
.text
.globl main

main:

	j input

input:
	la $a0, prompt			# Load prompt into address 0
	li $v0, 4			# Load string into opcode by
	syscall
	