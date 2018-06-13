# Aitor Mancisidor
# Examen 1, parte práctica
# 13/06/2018

.data
	vector: .word 1, 2, 3				# v = {1, 2, 3}
	matrix: .word 1, 2, 3, 4, 5, 6, 7, 8, 9 	# m = { {1, 2, 3}, {4, 5, 6}, {7, 8, 9} }
.text

	addi $v0, $zero, 0x10010040	# Direccion de resultado
	
	sw $zero, 0($v0)		# Initialize memory
	sw $zero, 4($v0)
	sw $zero, 8($v0)		

	addi $s0, $zero, 0	# i
	addi $s1, $zero, 0	# j
	addi $s2, $zero, 3	# matrix and vector size
	
	
#	la $s3, vector		# loading addresses
	la $s4, matrix
	
forI:
	beq $s0, $s2, exit	# break if i = 3
	la $s3, vector		# reset vector address
#	la $s4, matrix		# reset matrix address
	add $s1, $zero, $zero	# reset j
#	addi $s0, $s0, 1	# i++
		
forJ:	
	beq $s1, $s2, sumI	# Exit if j = 3
	lw $t0, 0($s3)		# Load value at vector
	lw $t1, 0($s4)		# Load first row matriz value
	
	mult $t0, $t1		# m[i][j] * v[j]
	mflo $t2		# Load result
	lw $t3, 0($v0)
	add $t3, $t3, $t2	# r[i] = r[i] + mult
	sw $t3, 0($v0)		# Store result
	
	addi $s1, $s1, 1	# j++
	addi $s3, $s3, 4	# Move vector pointer one position
	addi $s4, $s4, 4	# Move matrix position one position
		# This does not reset
	j forJ	# Volver a saltar al ciclo
	
sumI:
	addi $s0, $s0, 1	# i++
	addi $v0, $v0, 4	# Move result pointer one position
	j forI
	
exit:



	