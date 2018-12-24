# File:		traverse_tree.asm
# Author:	K. Reek
# Contributors:	P. White,
#		W. Carithers,
#		<<<YOUR NAME HERE>>>
#
# Description:	Binary tree traversal functions.
#
# Revisions:	$Log$


# CONSTANTS
#

# traversal codes
PRE_ORDER  = 0
IN_ORDER   = 1
POST_ORDER = 2

	.text			# this is program code
	.align 2		# instructions must be on word boundaries

#***** BEGIN STUDENT CODE BLOCK 3 *****************************
#
# Put your traverse_tree subroutine here.
# 
# 
# Name:		traverse_tree
#
# Description:	Traverses the given tree, traverse type is 
#					according to the above table
#
# Arguments:	a0 the address of the node to begin traversal
#   		a1 the address of processing function
#		a2 the type of traversal
# Returns:	none
#

.globl traverse_tree

traverse_tree:
	addi	$sp, $sp, -12
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	
	addi	$s0, $a0, 0	
	addi	$s1, $a1, 0
	
	beq	$a2, $zero, pre_order
	li	$t0, 1
	beq $a2, $t0, in_order
	li	$t0, 2
	beq	$a2, $t0, post_order
	jr	$ra		#error in input
	
	
post_order:		################################################################
	lw	$t0, 4($s0)	#get left child address
	beq $t0, $zero, no_left_post
	addi	$a0, $t0, 0
	addi	$a1, $s1, 0
	li	$a2, 2
	jal	traverse_tree	#Process Left Child
	
no_left_post:
	lw	$t0, 8($s0)	#get right child address
	beq $t0, $zero, no_right_post
	addi	$a0, $t0, 0
	addi	$a1, $s1, 0
	li	$a2, 2
	jal	traverse_tree	#Process Right Child
	
no_right_post:
	addi	$a0, $s0, 0	#Process Me
	jalr	$s1
	
	lw	$ra, 0($sp)	#Fix the s registers
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	addi	$sp, $sp, 12
	jr	$ra
	
	
in_order:		################################################################
	lw	$t0, 4($s0)	#get left child address
	beq $t0, $zero, no_left_in
	addi	$a0, $t0, 0
	addi	$a1, $s1, 0
	li	$a2, 1
	jal	traverse_tree	#Process Left Child
	
no_left_in:
	addi	$a0, $s0, 0	#Process Me
	jalr	$s1

	lw	$t0, 8($s0)	#get right child address
	beq $t0, $zero, no_right_in
	addi	$a0, $t0, 0
	addi	$a1, $s1, 0
	li	$a2, 1
	jal	traverse_tree	#Process Right Child
	
no_right_in:
	lw	$ra, 0($sp)	#Fix the s registers
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	addi	$sp, $sp, 12
	jr	$ra
	
	
pre_order:		################################################################
	addi	$a0, $s0, 0	#Process Me
	jalr	$s1
	
	lw	$t0, 4($s0)	#get left child address
	beq $t0, $zero, no_left_pre
	addi	$a0, $t0, 0
	addi	$a1, $s1, 0
	li	$a2, 0
	jal	traverse_tree	#Process Left Child
	
no_left_pre:
	lw	$t0, 8($s0)	#get right child address
	beq $t0, $zero, no_right_pre
	addi	$a0, $t0, 0
	addi	$a1, $s1, 0
	li	$a2, 0
	jal	traverse_tree	#Process Right Child
	
no_right_pre:
	lw	$ra, 0($sp)	#Fix the s registers
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	addi	$sp, $sp, 12
	jr	$ra

	
#***** END STUDENT CODE BLOCK 3 *****************************
