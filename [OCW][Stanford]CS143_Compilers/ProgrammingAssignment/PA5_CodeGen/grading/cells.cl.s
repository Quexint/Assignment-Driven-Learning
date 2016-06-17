	.data
	.align	2
	.globl	class_nameTab
	.globl	Main_protObj
	.globl	Int_protObj
	.globl	String_protObj
	.globl	bool_const0
	.globl	bool_const1
	.globl	_int_tag
	.globl	_bool_tag
	.globl	_string_tag
_int_tag:
	.word	1
_bool_tag:
	.word	2
_string_tag:
	.word	3
	.globl	_MemMgr_INITIALIZER
_MemMgr_INITIALIZER:
	.word	_NoGC_Init
	.globl	_MemMgr_COLLECTOR
_MemMgr_COLLECTOR:
	.word	_NoGC_Collect
	.globl	_MemMgr_TEST
_MemMgr_TEST:
	.word	0
	.word	-1
str_const16:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const1
	.byte	0	
	.align	2
	.word	-1
str_const15:
	.word	3
	.word	6
	.word	String_dispTab
	.word	int_const3
	.ascii	"Main"
	.byte	0	
	.align	2
	.word	-1
str_const14:
	.word	3
	.word	9
	.word	String_dispTab
	.word	int_const4
	.ascii	"CellularAutomaton"
	.byte	0	
	.align	2
	.word	-1
str_const13:
	.word	3
	.word	6
	.word	String_dispTab
	.word	int_const5
	.ascii	"String"
	.byte	0	
	.align	2
	.word	-1
str_const12:
	.word	3
	.word	6
	.word	String_dispTab
	.word	int_const3
	.ascii	"Bool"
	.byte	0	
	.align	2
	.word	-1
str_const11:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const6
	.ascii	"Int"
	.byte	0	
	.align	2
	.word	-1
str_const10:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const7
	.ascii	"IO"
	.byte	0	
	.align	2
	.word	-1
str_const9:
	.word	3
	.word	6
	.word	String_dispTab
	.word	int_const5
	.ascii	"Object"
	.byte	0	
	.align	2
	.word	-1
str_const8:
	.word	3
	.word	7
	.word	String_dispTab
	.word	int_const8
	.ascii	"_prim_slot"
	.byte	0	
	.align	2
	.word	-1
str_const7:
	.word	3
	.word	7
	.word	String_dispTab
	.word	int_const9
	.ascii	"SELF_TYPE"
	.byte	0	
	.align	2
	.word	-1
str_const6:
	.word	3
	.word	7
	.word	String_dispTab
	.word	int_const9
	.ascii	"_no_class"
	.byte	0	
	.align	2
	.word	-1
str_const5:
	.word	3
	.word	8
	.word	String_dispTab
	.word	int_const10
	.ascii	"<basic class>"
	.byte	0	
	.align	2
	.word	-1
str_const4:
	.word	3
	.word	9
	.word	String_dispTab
	.word	int_const11
	.ascii	"         X         "
	.byte	0	
	.align	2
	.word	-1
str_const3:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const0
	.ascii	"."
	.byte	0	
	.align	2
	.word	-1
str_const2:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const0
	.ascii	"X"
	.byte	0	
	.align	2
	.word	-1
str_const1:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const0
	.ascii	"\n"
	.byte	0	
	.align	2
	.word	-1
str_const0:
	.word	3
	.word	7
	.word	String_dispTab
	.word	int_const8
	.ascii	"./cells.cl"
	.byte	0	
	.align	2
	.word	-1
int_const11:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	19
	.word	-1
int_const10:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	13
	.word	-1
int_const9:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	9
	.word	-1
int_const8:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	10
	.word	-1
int_const7:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	2
	.word	-1
int_const6:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	3
	.word	-1
int_const5:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	6
	.word	-1
int_const4:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	17
	.word	-1
int_const3:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	4
	.word	-1
int_const2:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	20
	.word	-1
int_const1:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	0
	.word	-1
int_const0:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	1
	.word	-1
bool_const0:
	.word	2
	.word	4
	.word	Bool_dispTab
	.word	0
	.word	-1
bool_const1:
	.word	2
	.word	4
	.word	Bool_dispTab
	.word	1
class_nameTab:
	.word	str_const9
	.word	str_const11
	.word	str_const12
	.word	str_const13
	.word	str_const10
	.word	str_const14
	.word	str_const15
class_objTab:
	.word	Object_protObj
	.word	Object_init
	.word	Int_protObj
	.word	Int_init
	.word	Bool_protObj
	.word	Bool_init
	.word	String_protObj
	.word	String_init
	.word	IO_protObj
	.word	IO_init
	.word	CellularAutomaton_protObj
	.word	CellularAutomaton_init
	.word	Main_protObj
	.word	Main_init
Object_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
Main_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	Main.main
String_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	String.length
	.word	String.concat
	.word	String.substr
Bool_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
Int_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
IO_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	IO.out_string
	.word	IO.out_int
	.word	IO.in_string
	.word	IO.in_int
CellularAutomaton_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	IO.out_string
	.word	IO.out_int
	.word	IO.in_string
	.word	IO.in_int
	.word	CellularAutomaton.init
	.word	CellularAutomaton.print
	.word	CellularAutomaton.num_cells
	.word	CellularAutomaton.cell
	.word	CellularAutomaton.cell_left_neighbor
	.word	CellularAutomaton.cell_right_neighbor
	.word	CellularAutomaton.cell_at_next_evolution
	.word	CellularAutomaton.evolve
	.word	-1
Object_protObj:
	.word	0
	.word	3
	.word	Object_dispTab
	.word	-1
Main_protObj:
	.word	6
	.word	4
	.word	Main_dispTab
	.word	0
	.word	-1
String_protObj:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const1
	.word	0
	.word	-1
Bool_protObj:
	.word	2
	.word	4
	.word	Bool_dispTab
	.word	0
	.word	-1
Int_protObj:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	0
	.word	-1
IO_protObj:
	.word	4
	.word	3
	.word	IO_dispTab
	.word	-1
CellularAutomaton_protObj:
	.word	5
	.word	4
	.word	CellularAutomaton_dispTab
	.word	str_const16
	.globl	heap_start
heap_start:
	.word	0
	.text
	.globl	Main_init
	.globl	Int_init
	.globl	String_init
	.globl	Bool_init
	.globl	Main.main
Object_init:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	jr	$ra	
IO_init:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	Object_init
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	jr	$ra	
Int_init:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	Object_init
	li	$a0 0
	sw	$a0 12($s0)
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	jr	$ra	
Bool_init:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	Object_init
	li	$a0 0
	sw	$a0 12($s0)
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	jr	$ra	
String_init:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	Object_init
	la	$a0 int_const1
	sw	$a0 12($s0)
	li	$a0 0
	sw	$a0 16($s0)
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	jr	$ra	
Main_init:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	Object_init
	li	$a0 0
	sw	$a0 12($s0)
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	jr	$ra	
CellularAutomaton_init:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	IO_init
	la	$a0 str_const16
	sw	$a0 12($s0)
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	jr	$ra	
Main.main:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
# Begin of Assign 
  # Begin of dispatch init
	addiu	$sp $sp -4
	la	$a0 str_const4
	sw	$a0 4($sp)
	la	$a0 CellularAutomaton_protObj
	jal	Object.copy
	jal	CellularAutomaton_init
	bne	$zero $a0 label1
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label1:
	lw	$t1 8($a0)
	lw	$t1 28($t1)
	jalr		$t1
  # End of dispatch init
	sw	$a0 12($s0)
# End of Assign 
  # Begin of dispatch print
	addiu	$sp $sp 0
  # Try to find cells
# in the 3 of $s0
	lw	$a0 12($s0)
	bne	$zero $a0 label3
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label3:
	lw	$t1 8($a0)
	lw	$t1 32($t1)
	jalr		$t1
  # End of dispatch print
	la	$a0 Int_protObj
	la	$a0 int_const2
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	sw	$a0 0($sp)
	addiu	$sp $sp -4
label5:
	la	$a0 int_const1
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find countdown
# in the 3 of $sp
	lw	$a0 12($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	la	$a0 bool_const1
	la	$a1 bool_const0
	lw	$t1 12($t1)
	lw	$t2 12($t2)
	blt	$t1 $t2 label9
label8:
	la	$a0 bool_const0
	b	label10
label9:
	la	$a0 bool_const1
label10:
	move	$t1 $a0
	la	$t2 bool_const1
	beq	$t1 $t2 label6
	b	label7
label6:
  # Begin of dispatch evolve
	addiu	$sp $sp 0
  # Try to find cells
# in the 3 of $s0
	lw	$a0 12($s0)
	bne	$zero $a0 label11
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label11:
	lw	$t1 8($a0)
	lw	$t1 56($t1)
	jalr		$t1
  # End of dispatch evolve
  # Begin of dispatch print
	addiu	$sp $sp 0
  # Try to find cells
# in the 3 of $s0
	lw	$a0 12($s0)
	bne	$zero $a0 label13
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label13:
	lw	$t1 8($a0)
	lw	$t1 32($t1)
	jalr		$t1
  # End of dispatch print
# Begin of Assign 
  # Try to find countdown
# in the 2 of $sp
	lw	$a0 8($sp)
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 int_const0
	jal	Object.copy
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	move	$a0 $t1
	lw	$t1 12($t1)
	lw	$t2 12($t2)
	sub	$t1 $t1 $t2
	sw	$t1 12($a0)
	sw	$a0 8($sp)
# End of Assign 
	b	label5
label7:
	lw	$a0 4($sp)
	addiu	$sp $sp 4
	lw	$t3 4($sp)
	addiu	$sp $sp 4
  # Try to find self
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 0
	jr	$ra	
CellularAutomaton.init:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
# Begin of Assign 
  # Try to find map
# in the 4 of $sp
	lw	$a0 16($sp)
	sw	$a0 12($s0)
# End of Assign 
  # Try to find self
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 4
	jr	$ra	
CellularAutomaton.print:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
  # Begin of dispatch out_string
	addiu	$sp $sp -4
  # Begin of dispatch concat
	addiu	$sp $sp -4
	la	$a0 str_const1
	sw	$a0 4($sp)
  # Try to find population_map
# in the 3 of $s0
	lw	$a0 12($s0)
	bne	$zero $a0 label15
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label15:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch concat
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label17
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label17:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
  # End of dispatch out_string
  # Try to find self
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 0
	jr	$ra	
CellularAutomaton.num_cells:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
  # Begin of dispatch length
	addiu	$sp $sp 0
  # Try to find population_map
# in the 3 of $s0
	lw	$a0 12($s0)
	bne	$zero $a0 label19
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label19:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
  # End of dispatch length
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 0
	jr	$ra	
CellularAutomaton.cell:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
  # Begin of dispatch substr
	addiu	$sp $sp -8
  # Try to find position
# in the 6 of $sp
	lw	$a0 24($sp)
	sw	$a0 4($sp)
	la	$a0 int_const0
	jal	Object.copy
	sw	$a0 8($sp)
	lw	$t1 4($sp)
	lw	$t2 8($sp)
	sw	$t2 4($sp)
	sw	$t1 8($sp)
  # Try to find population_map
# in the 3 of $s0
	lw	$a0 12($s0)
	bne	$zero $a0 label21
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label21:
	lw	$t1 8($a0)
	lw	$t1 20($t1)
	jalr		$t1
  # End of dispatch substr
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 4
	jr	$ra	
CellularAutomaton.cell_left_neighbor:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
  # Try to find position
# in the 4 of $sp
	lw	$a0 16($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 int_const1
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	la	$a0 bool_const1
	la	$a1 bool_const0
	beq	$t1 $t2 label25
	jal	equality_test
	lw	$t3 12($a0)
	beqz	$t3 label23
	la	$a0 bool_const1
	b	label25
label23:
	la	$a0 bool_const0
label25:
	move	$t1 $a0
	la	$t2 bool_const1
	beq	$t1 $t2 label27
label26:
  # Begin of dispatch cell
	addiu	$sp $sp -4
  # Try to find position
# in the 5 of $sp
	lw	$a0 20($sp)
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 int_const0
	jal	Object.copy
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	move	$a0 $t1
	lw	$t1 12($t1)
	lw	$t2 12($t2)
	sub	$t1 $t1 $t2
	sw	$t1 12($a0)
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label29
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label29:
	lw	$t1 8($a0)
	lw	$t1 40($t1)
	jalr		$t1
  # End of dispatch cell
	b	label28
label27:
  # Begin of dispatch cell
	addiu	$sp $sp -4
  # Begin of dispatch num_cells
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label31
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label31:
	lw	$t1 8($a0)
	lw	$t1 36($t1)
	jalr		$t1
  # End of dispatch num_cells
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 int_const0
	jal	Object.copy
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	move	$a0 $t1
	lw	$t1 12($t1)
	lw	$t2 12($t2)
	sub	$t1 $t1 $t2
	sw	$t1 12($a0)
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label33
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label33:
	lw	$t1 8($a0)
	lw	$t1 40($t1)
	jalr		$t1
  # End of dispatch cell
label28:
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 4
	jr	$ra	
CellularAutomaton.cell_right_neighbor:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
  # Try to find position
# in the 4 of $sp
	lw	$a0 16($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Begin of dispatch num_cells
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label38
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label38:
	lw	$t1 8($a0)
	lw	$t1 36($t1)
	jalr		$t1
  # End of dispatch num_cells
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 int_const0
	jal	Object.copy
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	move	$a0 $t1
	lw	$t1 12($t1)
	lw	$t2 12($t2)
	sub	$t1 $t1 $t2
	sw	$t1 12($a0)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	la	$a0 bool_const1
	la	$a1 bool_const0
	beq	$t1 $t2 label37
	jal	equality_test
	lw	$t3 12($a0)
	beqz	$t3 label35
	la	$a0 bool_const1
	b	label37
label35:
	la	$a0 bool_const0
label37:
	move	$t1 $a0
	la	$t2 bool_const1
	beq	$t1 $t2 label41
label40:
  # Begin of dispatch cell
	addiu	$sp $sp -4
  # Try to find position
# in the 5 of $sp
	lw	$a0 20($sp)
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 int_const0
	jal	Object.copy
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	move	$a0 $t1
	lw	$t1 12($t1)
	lw	$t2 12($t2)
	add	$t1 $t1 $t2
	sw	$t1 12($a0)
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label43
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label43:
	lw	$t1 8($a0)
	lw	$t1 40($t1)
	jalr		$t1
  # End of dispatch cell
	b	label42
label41:
  # Begin of dispatch cell
	addiu	$sp $sp -4
	la	$a0 int_const1
	jal	Object.copy
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label45
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label45:
	lw	$t1 8($a0)
	lw	$t1 40($t1)
	jalr		$t1
  # End of dispatch cell
label42:
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 4
	jr	$ra	
CellularAutomaton.cell_at_next_evolution:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
  # Begin of dispatch cell
	addiu	$sp $sp -4
  # Try to find position
# in the 5 of $sp
	lw	$a0 20($sp)
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label53
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label53:
	lw	$t1 8($a0)
	lw	$t1 40($t1)
	jalr		$t1
  # End of dispatch cell
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 str_const2
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	la	$a0 bool_const1
	la	$a1 bool_const0
	beq	$t1 $t2 label52
	jal	equality_test
	lw	$t3 12($a0)
	beqz	$t3 label50
	la	$a0 bool_const1
	b	label52
label50:
	la	$a0 bool_const0
label52:
	move	$t1 $a0
	la	$t2 bool_const1
	beq	$t1 $t2 label56
label55:
	la	$a0 int_const1
	jal	Object.copy
	b	label57
label56:
	la	$a0 int_const0
	jal	Object.copy
label57:
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Begin of dispatch cell_left_neighbor
	addiu	$sp $sp -4
  # Try to find position
# in the 6 of $sp
	lw	$a0 24($sp)
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label61
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label61:
	lw	$t1 8($a0)
	lw	$t1 44($t1)
	jalr		$t1
  # End of dispatch cell_left_neighbor
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 str_const2
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	la	$a0 bool_const1
	la	$a1 bool_const0
	beq	$t1 $t2 label60
	jal	equality_test
	lw	$t3 12($a0)
	beqz	$t3 label58
	la	$a0 bool_const1
	b	label60
label58:
	la	$a0 bool_const0
label60:
	move	$t1 $a0
	la	$t2 bool_const1
	beq	$t1 $t2 label64
label63:
	la	$a0 int_const1
	jal	Object.copy
	b	label65
label64:
	la	$a0 int_const0
	jal	Object.copy
label65:
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	move	$a0 $t1
	lw	$t1 12($t1)
	lw	$t2 12($t2)
	add	$t1 $t1 $t2
	sw	$t1 12($a0)
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Begin of dispatch cell_right_neighbor
	addiu	$sp $sp -4
  # Try to find position
# in the 6 of $sp
	lw	$a0 24($sp)
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label69
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label69:
	lw	$t1 8($a0)
	lw	$t1 48($t1)
	jalr		$t1
  # End of dispatch cell_right_neighbor
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 str_const2
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	la	$a0 bool_const1
	la	$a1 bool_const0
	beq	$t1 $t2 label68
	jal	equality_test
	lw	$t3 12($a0)
	beqz	$t3 label66
	la	$a0 bool_const1
	b	label68
label66:
	la	$a0 bool_const0
label68:
	move	$t1 $a0
	la	$t2 bool_const1
	beq	$t1 $t2 label72
label71:
	la	$a0 int_const1
	jal	Object.copy
	b	label73
label72:
	la	$a0 int_const0
	jal	Object.copy
label73:
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	move	$a0 $t1
	lw	$t1 12($t1)
	lw	$t2 12($t2)
	add	$t1 $t1 $t2
	sw	$t1 12($a0)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 int_const0
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	la	$a0 bool_const1
	la	$a1 bool_const0
	beq	$t1 $t2 label49
	jal	equality_test
	lw	$t3 12($a0)
	beqz	$t3 label47
	la	$a0 bool_const1
	b	label49
label47:
	la	$a0 bool_const0
label49:
	move	$t1 $a0
	la	$t2 bool_const1
	beq	$t1 $t2 label75
label74:
	la	$a0 str_const3
	b	label76
label75:
	la	$a0 str_const2
label76:
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 4
	jr	$ra	
CellularAutomaton.evolve:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	la	$a0 Int_protObj
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 Int_protObj
  # Begin of dispatch num_cells
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label77
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label77:
	lw	$t1 8($a0)
	lw	$t1 36($t1)
	jalr		$t1
  # End of dispatch num_cells
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 String_protObj
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	sw	$a0 0($sp)
	addiu	$sp $sp -4
label79:
  # Try to find position
# in the 4 of $sp
	lw	$a0 16($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find num
# in the 4 of $sp
	lw	$a0 16($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	la	$a0 bool_const1
	la	$a1 bool_const0
	lw	$t1 12($t1)
	lw	$t2 12($t2)
	blt	$t1 $t2 label83
label82:
	la	$a0 bool_const0
	b	label84
label83:
	la	$a0 bool_const1
label84:
	move	$t1 $a0
	la	$t2 bool_const1
	beq	$t1 $t2 label80
	b	label81
label80:
# Begin of Assign 
  # Begin of dispatch concat
	addiu	$sp $sp -4
  # Begin of dispatch cell_at_next_evolution
	addiu	$sp $sp -4
  # Try to find position
# in the 6 of $sp
	lw	$a0 24($sp)
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label85
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label85:
	lw	$t1 8($a0)
	lw	$t1 52($t1)
	jalr		$t1
  # End of dispatch cell_at_next_evolution
	sw	$a0 4($sp)
  # Try to find temp
# in the 3 of $sp
	lw	$a0 12($sp)
	bne	$zero $a0 label87
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label87:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch concat
	sw	$a0 8($sp)
# End of Assign 
# Begin of Assign 
  # Try to find position
# in the 4 of $sp
	lw	$a0 16($sp)
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 int_const0
	jal	Object.copy
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	move	$a0 $t1
	lw	$t1 12($t1)
	lw	$t2 12($t2)
	add	$t1 $t1 $t2
	sw	$t1 12($a0)
	sw	$a0 16($sp)
# End of Assign 
	b	label79
label81:
	lw	$a0 4($sp)
	addiu	$sp $sp 4
# Begin of Assign 
  # Try to find temp
# in the 1 of $sp
	lw	$a0 4($sp)
	sw	$a0 12($s0)
# End of Assign 
  # Try to find self
	move	$a0 $s0
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 0
	jr	$ra	
