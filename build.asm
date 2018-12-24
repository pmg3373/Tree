# File:		build.asm
# Author:	K. Reek
# Contributors:	P. White,
#		W. Carithers,
#		<<<YOUR NAME HERE>>>
#
# Description:	Binary tree building functions.
#
# Revisions:	$Log$

	.data
	.align 2
		.word node_memory_pointer
	node_memory_pointer:	.word 0
	.text			# this is program code
	.align 2		# instructions must be on word boundaries

# 
# Name:		add_elements
#
# Description:	loops through array of numbers, adding each (in order)
#		to the tree
#
# Arguments:	a0 the address of the array
#   		a1 the number of elements in the array
#		a2 the address of the root pointer
# Returns:	none
#

	.globl	add_elements
	
add_elements:
	addi 	$sp, $sp, -16
	sw 	$ra, 12($sp)
	sw 	$s2, 8($sp)
	sw 	$s1, 4($sp)
	sw 	$s0, 0($sp)

#***** BEGIN STUDENT CODE BLOCK 1 ***************************
#
# Insert your code to iterate through the array, calling build_tree
# for each value in the array.  Remember that build_tree requires
# two parameters:  the address of the variable which contains the
# root pointer for the tree, and the number to be inserted.
#
# Feel free to save extra "S" registers onto the stack if you need
# more for your function.
#

#
# If you saved extra "S" reg to stack, make sure you restore them
#

	addi	$s0, $a0, 0
	addi	$s1, $a1, 0
	addi	$s2, $a2, 0
	
begin_loop_add:
	lw $a1, 0($s0)
	addi $s0, $s0, 4
	addi $s1, $s1, -1
	addi $a0, $s2, 0
	jal	build_tree
	bne $s1, $zero, begin_loop_add

#***** END STUDENT CODE BLOCK 1 *****************************

add_done:

	lw 	$ra, 12($sp)
	lw 	$s2, 8($sp)
	lw 	$s1, 4($sp)
	lw 	$s0, 0($sp)
	addi 	$sp, $sp, 16
	jr 	$ra

#***** BEGIN STUDENT CODE BLOCK 2 ***************************
#
# Put your build_tree subroutine here.
#
# 
# Name:		build_tree
#
# Description:	inserts a single element into the tree
#
# Arguments:	a0 the address of the root node
#   		a1 the number to insert
# Returns:	none
#
.globl allocate_mem
build_tree:
	addi $sp, $sp, -8
	sw	$s0, 0($sp)
	sw	$s1, 4($sp)
	
	addi	$s0, $a0, 0
	addi	$s1, $a1, 0
	
	lw	$t0, 0($s0)		#Loads pointer to root node
	bne	$t0, $zero, begin_iter
	
	li	$a0, 3		#3 words per node
	jal allocate_mem
	
	sw	$v0, 0($s0)		#store address of my memory in address passed
	sw	$s1, 0($v0)		#store the number at my root address
	sw	$zero, 4($v0)	#be sure to zero pointers to children
	sw	$zero, 8($v0)
	
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	addi $sp, $sp, 8
	jr	$ra
	
	
begin_iter:
	lw	$t1, 0($t0)		#Loads root node value
	beq	$t1, $s1, end_iter
	
	slt $t2, $t1, $s1
	bne $t2, $zero, less_than
	
	lw	$t0, 8($t0)		#get right child, the number is bigger
	bne	$t0, $zero, have_right
	li	$a0, 3		#3 words per node
	jal allocate_mem
	sw	$v0, 8($t1)
	sw	$s1, 0($v0)
	sw	$zero, 4($v0)	#be sure to zero pointers to children
	sw	$zero, 8($v0)
	
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	addi $sp, $sp, 8
	jr $ra
have_right:
	addi $t0, $t1, 8
	j begin_iter
	
less_than:
	lw	$t0, 4($t0)		#get right child, the number is bigger
	bne	$t0, $zero, have_left
	li	$a0, 3		#3 words per node
	jal allocate_mem
	sw	$v0, 4($t1)
	sw	$s1, 0($v0)
	sw	$zero, 4($v0)	#be sure to zero pointers to children
	sw	$zero, 8($v0)
	
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	addi $sp, $sp, 8
	jr $ra
have_left:
	addi $t0, $t1, 4
	j begin_iter
	
end_iter:
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	addi $sp, $sp, 8
	jr	$ra
#***** END STUDENT CODE BLOCK 2 *****************************
