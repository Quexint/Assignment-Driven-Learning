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
	.word	int_const6
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
	.word	5
	.word	String_dispTab
	.word	int_const0
	.ascii	"D"
	.byte	0	
	.align	2
	.word	-1
str_const13:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const0
	.ascii	"C"
	.byte	0	
	.align	2
	.word	-1
str_const12:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const0
	.ascii	"B"
	.byte	0	
	.align	2
	.word	-1
str_const11:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const0
	.ascii	"A"
	.byte	0	
	.align	2
	.word	-1
str_const10:
	.word	3
	.word	6
	.word	String_dispTab
	.word	int_const5
	.ascii	"String"
	.byte	0	
	.align	2
	.word	-1
str_const9:
	.word	3
	.word	6
	.word	String_dispTab
	.word	int_const3
	.ascii	"Bool"
	.byte	0	
	.align	2
	.word	-1
str_const8:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const2
	.ascii	"Int"
	.byte	0	
	.align	2
	.word	-1
str_const7:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const1
	.ascii	"IO"
	.byte	0	
	.align	2
	.word	-1
str_const6:
	.word	3
	.word	6
	.word	String_dispTab
	.word	int_const5
	.ascii	"Object"
	.byte	0	
	.align	2
	.word	-1
str_const5:
	.word	3
	.word	7
	.word	String_dispTab
	.word	int_const7
	.ascii	"_prim_slot"
	.byte	0	
	.align	2
	.word	-1
str_const4:
	.word	3
	.word	7
	.word	String_dispTab
	.word	int_const8
	.ascii	"SELF_TYPE"
	.byte	0	
	.align	2
	.word	-1
str_const3:
	.word	3
	.word	7
	.word	String_dispTab
	.word	int_const8
	.ascii	"_no_class"
	.byte	0	
	.align	2
	.word	-1
str_const2:
	.word	3
	.word	8
	.word	String_dispTab
	.word	int_const9
	.ascii	"<basic class>"
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
	.word	8
	.word	String_dispTab
	.word	int_const9
	.ascii	"./override.cl"
	.byte	0	
	.align	2
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
	.word	0
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
	.word	5
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
	.word	2
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
	.word	str_const6
	.word	str_const8
	.word	str_const9
	.word	str_const10
	.word	str_const7
	.word	str_const11
	.word	str_const12
	.word	str_const13
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
	.word	A_protObj
	.word	A_init
	.word	B_protObj
	.word	B_init
	.word	C_protObj
	.word	C_init
	.word	D_protObj
	.word	D_init
	.word	Main_protObj
	.word	Main_init
Object_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
A_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	A.f
	.word	A.g
B_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	A.f
	.word	B.g
C_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	C.f
	.word	B.g
D_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	D.f
	.word	D.g
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
Main_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	IO.out_string
	.word	IO.out_int
	.word	IO.in_string
	.word	IO.in_int
	.word	Main.main
	.word	-1
Object_protObj:
	.word	0
	.word	3
	.word	Object_dispTab
	.word	-1
A_protObj:
	.word	5
	.word	3
	.word	A_dispTab
	.word	-1
B_protObj:
	.word	6
	.word	3
	.word	B_dispTab
	.word	-1
C_protObj:
	.word	7
	.word	3
	.word	C_dispTab
	.word	-1
D_protObj:
	.word	8
	.word	3
	.word	D_dispTab
	.word	-1
String_protObj:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const6
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
Main_protObj:
	.word	9
	.word	7
	.word	Main_dispTab
	.word	0
	.word	0
	.word	0
	.word	0
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
	la	$a0 int_const6
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
	jal	IO_init
	li	$a0 0
	la	$a0 A_protObj
	jal	Object.copy
	jal	A_init
	sw	$a0 12($s0)
	li	$a0 0
	la	$a0 B_protObj
	jal	Object.copy
	jal	B_init
	sw	$a0 16($s0)
	li	$a0 0
	la	$a0 C_protObj
	jal	Object.copy
	jal	C_init
	sw	$a0 20($s0)
	li	$a0 0
	la	$a0 D_protObj
	jal	Object.copy
	jal	D_init
	sw	$a0 24($s0)
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
C_init:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	B_init
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	jr	$ra	
D_init:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	C_init
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	jr	$ra	
A.f:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	la	$a0 int_const0
	jal	Object.copy
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 0
	jr	$ra	
A.g:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	la	$a0 int_const1
	jal	Object.copy
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 0
	jr	$ra	
B.g:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	la	$a0 int_const2
	jal	Object.copy
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 0
	jr	$ra	
C.f:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	la	$a0 int_const3
	jal	Object.copy
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 0
	jr	$ra	
D.f:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	la	$a0 int_const4
	jal	Object.copy
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 0
	jr	$ra	
D.g:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	la	$a0 int_const5
	jal	Object.copy
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 0
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
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of dispatch f
	addiu	$sp $sp 0
  # Try to find a
# in the 3 of $s0
	lw	$a0 12($s0)
	bne	$zero $a0 label1
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label1:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
  # End of dispatch f
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label3
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label3:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of dispatch g
	addiu	$sp $sp 0
  # Try to find a
# in the 3 of $s0
	lw	$a0 12($s0)
	bne	$zero $a0 label5
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label5:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch g
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label7
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label7:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of dispatch f
	addiu	$sp $sp 0
  # Try to find b
# in the 4 of $s0
	lw	$a0 16($s0)
	bne	$zero $a0 label9
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label9:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
  # End of dispatch f
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label11
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label11:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of dispatch g
	addiu	$sp $sp 0
  # Try to find b
# in the 4 of $s0
	lw	$a0 16($s0)
	bne	$zero $a0 label13
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label13:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch g
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label15
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label15:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of dispatch f
	addiu	$sp $sp 0
  # Try to find c
# in the 5 of $s0
	lw	$a0 20($s0)
	bne	$zero $a0 label17
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label17:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
  # End of dispatch f
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label19
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label19:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of dispatch g
	addiu	$sp $sp 0
  # Try to find c
# in the 5 of $s0
	lw	$a0 20($s0)
	bne	$zero $a0 label21
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label21:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch g
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label23
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label23:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of dispatch f
	addiu	$sp $sp 0
  # Try to find d
# in the 6 of $s0
	lw	$a0 24($s0)
	bne	$zero $a0 label25
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label25:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
  # End of dispatch f
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label27
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label27:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of dispatch g
	addiu	$sp $sp 0
  # Try to find d
# in the 6 of $s0
	lw	$a0 24($s0)
	bne	$zero $a0 label29
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label29:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch g
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label31
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label31:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of static dispatch f
	addiu	$sp $sp 0
  # Try to find a
# in the 3 of $s0
	lw	$a0 12($s0)
	bne	$zero $a0 label33
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label33:
	la	$t1 A_dispTab
	lw	$t1 12($t1)
	jalr		$t1
  # End of static f
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label35
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label35:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of static dispatch g
	addiu	$sp $sp 0
  # Try to find a
# in the 3 of $s0
	lw	$a0 12($s0)
	bne	$zero $a0 label37
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label37:
	la	$t1 A_dispTab
	lw	$t1 16($t1)
	jalr		$t1
  # End of static g
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label39
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label39:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of static dispatch f
	addiu	$sp $sp 0
  # Try to find b
# in the 4 of $s0
	lw	$a0 16($s0)
	bne	$zero $a0 label41
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label41:
	la	$t1 A_dispTab
	lw	$t1 12($t1)
	jalr		$t1
  # End of static f
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label43
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label43:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of static dispatch g
	addiu	$sp $sp 0
  # Try to find b
# in the 4 of $s0
	lw	$a0 16($s0)
	bne	$zero $a0 label45
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label45:
	la	$t1 A_dispTab
	lw	$t1 16($t1)
	jalr		$t1
  # End of static g
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label47
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label47:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of static dispatch f
	addiu	$sp $sp 0
  # Try to find c
# in the 5 of $s0
	lw	$a0 20($s0)
	bne	$zero $a0 label49
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label49:
	la	$t1 B_dispTab
	lw	$t1 12($t1)
	jalr		$t1
  # End of static f
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label51
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label51:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of static dispatch g
	addiu	$sp $sp 0
  # Try to find c
# in the 5 of $s0
	lw	$a0 20($s0)
	bne	$zero $a0 label53
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label53:
	la	$t1 B_dispTab
	lw	$t1 16($t1)
	jalr		$t1
  # End of static g
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label55
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label55:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of static dispatch f
	addiu	$sp $sp 0
  # Try to find d
# in the 6 of $s0
	lw	$a0 24($s0)
	bne	$zero $a0 label57
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label57:
	la	$t1 C_dispTab
	lw	$t1 12($t1)
	jalr		$t1
  # End of static f
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label59
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label59:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of static dispatch g
	addiu	$sp $sp 0
  # Try to find d
# in the 6 of $s0
	lw	$a0 24($s0)
	bne	$zero $a0 label61
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label61:
	la	$t1 C_dispTab
	lw	$t1 16($t1)
	jalr		$t1
  # End of static g
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label63
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label63:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
# Begin of Assign 
	la	$a0 B_protObj
	jal	Object.copy
	jal	B_init
	sw	$a0 12($s0)
# End of Assign 
# Begin of Assign 
	la	$a0 C_protObj
	jal	Object.copy
	jal	C_init
	sw	$a0 16($s0)
# End of Assign 
# Begin of Assign 
	la	$a0 D_protObj
	jal	Object.copy
	jal	D_init
	sw	$a0 20($s0)
# End of Assign 
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of dispatch f
	addiu	$sp $sp 0
  # Try to find a
# in the 3 of $s0
	lw	$a0 12($s0)
	bne	$zero $a0 label65
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label65:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
  # End of dispatch f
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label67
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label67:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of dispatch g
	addiu	$sp $sp 0
  # Try to find a
# in the 3 of $s0
	lw	$a0 12($s0)
	bne	$zero $a0 label69
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label69:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch g
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label71
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label71:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of dispatch f
	addiu	$sp $sp 0
  # Try to find b
# in the 4 of $s0
	lw	$a0 16($s0)
	bne	$zero $a0 label73
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label73:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
  # End of dispatch f
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label75
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label75:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of dispatch g
	addiu	$sp $sp 0
  # Try to find b
# in the 4 of $s0
	lw	$a0 16($s0)
	bne	$zero $a0 label77
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label77:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch g
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label79
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label79:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of dispatch f
	addiu	$sp $sp 0
  # Try to find c
# in the 5 of $s0
	lw	$a0 20($s0)
	bne	$zero $a0 label81
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label81:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
  # End of dispatch f
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label83
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label83:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_int
	addiu	$sp $sp -4
  # Begin of dispatch g
	addiu	$sp $sp 0
  # Try to find c
# in the 5 of $s0
	lw	$a0 20($s0)
	bne	$zero $a0 label85
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label85:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch g
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label87
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label87:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
  # Begin of dispatch out_string
	addiu	$sp $sp -4
	la	$a0 str_const1
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label89
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label89:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
  # End of dispatch out_string
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 0
	jr	$ra	
