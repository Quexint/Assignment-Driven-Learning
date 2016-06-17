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
str_const13:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const1
	.byte	0	
	.align	2
	.word	-1
str_const12:
	.word	3
	.word	6
	.word	String_dispTab
	.word	int_const3
	.ascii	"Main"
	.byte	0	
	.align	2
	.word	-1
str_const11:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const4
	.ascii	"B"
	.byte	0	
	.align	2
	.word	-1
str_const10:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const4
	.ascii	"A"
	.byte	0	
	.align	2
	.word	-1
str_const9:
	.word	3
	.word	6
	.word	String_dispTab
	.word	int_const5
	.ascii	"String"
	.byte	0	
	.align	2
	.word	-1
str_const8:
	.word	3
	.word	6
	.word	String_dispTab
	.word	int_const3
	.ascii	"Bool"
	.byte	0	
	.align	2
	.word	-1
str_const7:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const2
	.ascii	"Int"
	.byte	0	
	.align	2
	.word	-1
str_const6:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const6
	.ascii	"IO"
	.byte	0	
	.align	2
	.word	-1
str_const5:
	.word	3
	.word	6
	.word	String_dispTab
	.word	int_const5
	.ascii	"Object"
	.byte	0	
	.align	2
	.word	-1
str_const4:
	.word	3
	.word	7
	.word	String_dispTab
	.word	int_const7
	.ascii	"_prim_slot"
	.byte	0	
	.align	2
	.word	-1
str_const3:
	.word	3
	.word	7
	.word	String_dispTab
	.word	int_const8
	.ascii	"SELF_TYPE"
	.byte	0	
	.align	2
	.word	-1
str_const2:
	.word	3
	.word	7
	.word	String_dispTab
	.word	int_const8
	.ascii	"_no_class"
	.byte	0	
	.align	2
	.word	-1
str_const1:
	.word	3
	.word	8
	.word	String_dispTab
	.word	int_const9
	.ascii	"<basic class>"
	.byte	0	
	.align	2
	.word	-1
str_const0:
	.word	3
	.word	9
	.word	String_dispTab
	.word	int_const10
	.ascii	"./objectequality.cl"
	.byte	0	
	.align	2
	.word	-1
int_const10:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	19
	.word	-1
int_const9:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	13
	.word	-1
int_const8:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	9
	.word	-1
int_const7:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	10
	.word	-1
int_const6:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	2
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
	.word	1
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
	.word	3
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
	.word	5
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
	.word	str_const5
	.word	str_const7
	.word	str_const8
	.word	str_const9
	.word	str_const6
	.word	str_const10
	.word	str_const11
	.word	str_const12
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
	.word	A_protObj
	.word	A_init
	.word	B_protObj
	.word	B_init
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
A_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	A.foo
B_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	A.foo
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
	.word	-1
Object_protObj:
	.word	0
	.word	3
	.word	Object_dispTab
	.word	-1
Main_protObj:
	.word	7
	.word	3
	.word	Main_dispTab
	.word	-1
A_protObj:
	.word	5
	.word	4
	.word	A_dispTab
	.word	int_const1
	.word	-1
B_protObj:
	.word	6
	.word	4
	.word	B_dispTab
	.word	int_const1
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
A_init:
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
	la	$a0 int_const0
	jal	Object.copy
	sw	$a0 12($s0)
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
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	jr	$ra	
B_init:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	A_init
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
	move	$a0 $zero
	la	$a0 B_protObj
	jal	Object.copy
	jal	B_init
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find x
# in the 1 of $sp
	lw	$a0 4($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find x
# in the 2 of $sp
	lw	$a0 8($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	la	$a0 bool_const1
	la	$a1 bool_const0
	beq	$t1 $t2 label3
	jal	equality_test
	lw	$t3 12($a0)
	beqz	$t3 label1
	la	$a0 bool_const1
	b	label3
label1:
	la	$a0 bool_const0
label3:
	move	$t1 $a0
	la	$t2 bool_const1
	beq	$t1 $t2 label5
label4:
  # Begin of dispatch abort
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label7
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label7:
	lw	$t1 8($a0)
	lw	$t1 0($t1)
	jalr		$t1
  # End of dispatch abort
	b	label6
label5:
	la	$a0 int_const1
	jal	Object.copy
label6:
  # Try to find x
# in the 1 of $sp
	lw	$a0 4($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 B_protObj
	jal	Object.copy
	jal	B_init
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	la	$a0 bool_const1
	la	$a1 bool_const0
	beq	$t1 $t2 label11
	jal	equality_test
	lw	$t3 12($a0)
	beqz	$t3 label9
	la	$a0 bool_const1
	b	label11
label9:
	la	$a0 bool_const0
label11:
	move	$t1 $a0
	la	$t2 bool_const1
	beq	$t1 $t2 label13
label12:
	la	$a0 int_const1
	jal	Object.copy
	b	label14
label13:
  # Begin of dispatch abort
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label15
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label15:
	lw	$t1 8($a0)
	lw	$t1 0($t1)
	jalr		$t1
  # End of dispatch abort
label14:
	la	$a0 A_protObj
	jal	Object.copy
	jal	A_init
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 A_protObj
	jal	Object.copy
	jal	A_init
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	la	$a0 bool_const1
	la	$a1 bool_const0
	beq	$t1 $t2 label19
	jal	equality_test
	lw	$t3 12($a0)
	beqz	$t3 label17
	la	$a0 bool_const1
	b	label19
label17:
	la	$a0 bool_const0
label19:
	move	$t1 $a0
	la	$t2 bool_const1
	beq	$t1 $t2 label21
label20:
	la	$a0 int_const1
	jal	Object.copy
	b	label22
label21:
  # Begin of dispatch abort
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label23
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label23:
	lw	$t1 8($a0)
	lw	$t1 0($t1)
	jalr		$t1
  # End of dispatch abort
label22:
	move	$a0 $zero
  # Try to find x
# in the 1 of $sp
	lw	$a0 4($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find y
# in the 1 of $sp
	lw	$a0 4($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find x
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
	beq	$t1 $t2 label27
	jal	equality_test
	lw	$t3 12($a0)
	beqz	$t3 label25
	la	$a0 bool_const1
	b	label27
label25:
	la	$a0 bool_const0
label27:
	move	$t1 $a0
	la	$t2 bool_const1
	beq	$t1 $t2 label29
label28:
  # Begin of dispatch abort
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label31
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label31:
	lw	$t1 8($a0)
	lw	$t1 0($t1)
	jalr		$t1
  # End of dispatch abort
	b	label30
label29:
	la	$a0 int_const1
	jal	Object.copy
label30:
  # Begin of dispatch foo
	addiu	$sp $sp -4
	la	$a0 int_const2
	jal	Object.copy
	sw	$a0 4($sp)
  # Try to find y
# in the 2 of $sp
	lw	$a0 8($sp)
	bne	$zero $a0 label36
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label36:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
  # End of dispatch foo
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find x
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
	beq	$t1 $t2 label35
	jal	equality_test
	lw	$t3 12($a0)
	beqz	$t3 label33
	la	$a0 bool_const1
	b	label35
label33:
	la	$a0 bool_const0
label35:
	move	$t1 $a0
	la	$t2 bool_const1
	beq	$t1 $t2 label39
label38:
  # Begin of dispatch abort
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label41
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label41:
	lw	$t1 8($a0)
	lw	$t1 0($t1)
	jalr		$t1
  # End of dispatch abort
	b	label40
label39:
	la	$a0 int_const1
	jal	Object.copy
label40:
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	move	$a0 $zero
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	move	$a0 $zero
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find x
# in the 2 of $sp
	lw	$a0 8($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find y
# in the 2 of $sp
	lw	$a0 8($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	la	$a0 bool_const1
	la	$a1 bool_const0
	beq	$t1 $t2 label45
	jal	equality_test
	lw	$t3 12($a0)
	beqz	$t3 label43
	la	$a0 bool_const1
	b	label45
label43:
	la	$a0 bool_const0
label45:
	move	$t1 $a0
	la	$t2 bool_const1
	beq	$t1 $t2 label47
label46:
  # Begin of dispatch abort
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label49
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label49:
	lw	$t1 8($a0)
	lw	$t1 0($t1)
	jalr		$t1
  # End of dispatch abort
	b	label48
label47:
	la	$a0 int_const1
	jal	Object.copy
label48:
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
A.foo:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
# Begin of Assign 
  # Try to find y
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
