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
	.word	int_const2
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
	.word	6
	.word	String_dispTab
	.word	int_const3
	.ascii	"Bazz"
	.byte	0	
	.align	2
	.word	-1
str_const13:
	.word	3
	.word	6
	.word	String_dispTab
	.word	int_const3
	.ascii	"Razz"
	.byte	0	
	.align	2
	.word	-1
str_const12:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const4
	.ascii	"Bar"
	.byte	0	
	.align	2
	.word	-1
str_const11:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const4
	.ascii	"Foo"
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
	.word	int_const4
	.ascii	"Int"
	.byte	0	
	.align	2
	.word	-1
str_const7:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const0
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
	.word	int_const6
	.ascii	"_prim_slot"
	.byte	0	
	.align	2
	.word	-1
str_const4:
	.word	3
	.word	7
	.word	String_dispTab
	.word	int_const7
	.ascii	"SELF_TYPE"
	.byte	0	
	.align	2
	.word	-1
str_const3:
	.word	3
	.word	7
	.word	String_dispTab
	.word	int_const7
	.ascii	"_no_class"
	.byte	0	
	.align	2
	.word	-1
str_const2:
	.word	3
	.word	8
	.word	String_dispTab
	.word	int_const8
	.ascii	"<basic class>"
	.byte	0	
	.align	2
	.word	-1
str_const1:
	.word	3
	.word	7
	.word	String_dispTab
	.word	int_const6
	.ascii	"do nothing"
	.byte	0	
	.align	2
	.word	-1
str_const0:
	.word	3
	.word	8
	.word	String_dispTab
	.word	int_const9
	.ascii	"./hairyscary.cl"
	.byte	0	
	.align	2
	.word	-1
int_const9:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	15
	.word	-1
int_const8:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	13
	.word	-1
int_const7:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	9
	.word	-1
int_const6:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	10
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
	.word	3
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
	.word	0
	.word	-1
int_const1:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	1
	.word	-1
int_const0:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	2
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
	.word	Foo_protObj
	.word	Foo_init
	.word	Bar_protObj
	.word	Bar_init
	.word	Razz_protObj
	.word	Razz_init
	.word	Bazz_protObj
	.word	Bazz_init
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
Bazz_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	IO.out_string
	.word	IO.out_int
	.word	IO.in_string
	.word	IO.in_int
	.word	Bazz.printh
	.word	Bazz.doh
Foo_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	IO.out_string
	.word	IO.out_int
	.word	IO.in_string
	.word	IO.in_int
	.word	Bazz.printh
	.word	Foo.doh
Razz_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	IO.out_string
	.word	IO.out_int
	.word	IO.in_string
	.word	IO.in_int
	.word	Bazz.printh
	.word	Foo.doh
Bar_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	IO.out_string
	.word	IO.out_int
	.word	IO.in_string
	.word	IO.in_int
	.word	Bazz.printh
	.word	Foo.doh
	.word	-1
Object_protObj:
	.word	0
	.word	3
	.word	Object_dispTab
	.word	-1
Main_protObj:
	.word	9
	.word	7
	.word	Main_dispTab
	.word	0
	.word	0
	.word	0
	.word	0
	.word	-1
String_protObj:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const2
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
Bazz_protObj:
	.word	8
	.word	6
	.word	Bazz_dispTab
	.word	int_const2
	.word	0
	.word	0
	.word	-1
Foo_protObj:
	.word	5
	.word	8
	.word	Foo_dispTab
	.word	int_const2
	.word	0
	.word	0
	.word	0
	.word	int_const2
	.word	-1
Razz_protObj:
	.word	7
	.word	10
	.word	Razz_dispTab
	.word	int_const2
	.word	0
	.word	0
	.word	0
	.word	int_const2
	.word	0
	.word	int_const2
	.word	-1
Bar_protObj:
	.word	6
	.word	12
	.word	Bar_dispTab
	.word	int_const2
	.word	0
	.word	0
	.word	0
	.word	int_const2
	.word	0
	.word	int_const2
	.word	int_const2
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
	la	$a0 int_const2
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
	la	$a0 Bazz_protObj
	jal	Object.copy
	jal	Bazz_init
	sw	$a0 12($s0)
	li	$a0 0
	la	$a0 Foo_protObj
	jal	Object.copy
	jal	Foo_init
	sw	$a0 16($s0)
	li	$a0 0
	la	$a0 Razz_protObj
	jal	Object.copy
	jal	Razz_init
	sw	$a0 20($s0)
	li	$a0 0
	la	$a0 Bar_protObj
	jal	Object.copy
	jal	Bar_init
	sw	$a0 24($s0)
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	jr	$ra	
Bazz_init:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	IO_init
	la	$a0 int_const2
	la	$a0 int_const1
	jal	Object.copy
	sw	$a0 12($s0)
	li	$a0 0
  # Try to find self
	move	$a0 $s0
	move	$t1 $a0
	move	$a0 $s0
	bne	$zero $t1 label1
	li	$t1 1
	la	$a0 str_const0
	jal	_case_abort2
label1:
	move	$a0 $t1
	move	$t1 $a0
	sw	$t1 0($sp)
	addiu	$sp $sp -4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	sw	$t1 0($sp)
	addiu	$sp $sp -4
	lw	$t1 0($t1)
	la	$t2 Bazz_protObj
	lw	$t2 0($t2)
	beq	$t1 $t2 label2
	b	label3
label2:
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 Foo_protObj
	jal	Object.copy
	jal	Foo_init
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	b	label10
label3:
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	sw	$t1 0($sp)
	addiu	$sp $sp -4
	lw	$t1 0($t1)
	la	$t2 Razz_protObj
	lw	$t2 0($t2)
	beq	$t1 $t2 label4
	b	label5
label4:
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 Bar_protObj
	jal	Object.copy
	jal	Bar_init
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	b	label10
label5:
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	sw	$t1 0($sp)
	addiu	$sp $sp -4
	lw	$t1 0($t1)
	la	$t2 Foo_protObj
	lw	$t2 0($t2)
	beq	$t1 $t2 label6
	b	label7
label6:
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 Razz_protObj
	jal	Object.copy
	jal	Razz_init
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	b	label10
label7:
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	sw	$t1 0($sp)
	addiu	$sp $sp -4
	lw	$t1 0($t1)
	la	$t2 Bar_protObj
	lw	$t2 0($t2)
	beq	$t1 $t2 label8
	b	label9
label8:
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find n
# in the 1 of $sp
	lw	$a0 4($sp)
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	b	label10
label9:
	move	$a0 $s0
	jal	_case_abort
label10:
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	sw	$a0 16($s0)
	li	$a0 0
  # Begin of dispatch printh
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label11
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label11:
	lw	$t1 8($a0)
	lw	$t1 28($t1)
	jalr		$t1
  # End of dispatch printh
	sw	$a0 20($s0)
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	jr	$ra	
Foo_init:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	Bazz_init
	li	$a0 0
  # Try to find self
	move	$a0 $s0
	move	$t1 $a0
	move	$a0 $s0
	bne	$zero $t1 label13
	li	$t1 1
	la	$a0 str_const0
	jal	_case_abort2
label13:
	move	$a0 $t1
	move	$t1 $a0
	sw	$t1 0($sp)
	addiu	$sp $sp -4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	sw	$t1 0($sp)
	addiu	$sp $sp -4
	lw	$t1 0($t1)
	la	$t2 Razz_protObj
	lw	$t2 0($t2)
	beq	$t1 $t2 label14
	b	label15
label14:
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 Bar_protObj
	jal	Object.copy
	jal	Bar_init
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	b	label20
label15:
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	sw	$t1 0($sp)
	addiu	$sp $sp -4
	lw	$t1 0($t1)
	la	$t2 Foo_protObj
	lw	$t2 0($t2)
	beq	$t1 $t2 label16
	b	label17
label16:
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 Razz_protObj
	jal	Object.copy
	jal	Razz_init
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	b	label20
label17:
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	sw	$t1 0($sp)
	addiu	$sp $sp -4
	lw	$t1 0($t1)
	la	$t2 Bar_protObj
	lw	$t2 0($t2)
	beq	$t1 $t2 label18
	b	label19
label18:
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find n
# in the 1 of $sp
	lw	$a0 4($sp)
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	b	label20
label19:
	move	$a0 $s0
	jal	_case_abort
label20:
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	sw	$a0 24($s0)
	la	$a0 int_const2
  # Begin of dispatch doh
	addiu	$sp $sp 0
  # Try to find a
# in the 6 of $s0
	lw	$a0 24($s0)
	bne	$zero $a0 label21
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label21:
	lw	$t1 8($a0)
	lw	$t1 32($t1)
	jalr		$t1
  # End of dispatch doh
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Begin of dispatch doh
	addiu	$sp $sp 0
  # Try to find g
# in the 4 of $s0
	lw	$a0 16($s0)
	bne	$zero $a0 label23
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label23:
	lw	$t1 8($a0)
	lw	$t1 32($t1)
	jalr		$t1
  # End of dispatch doh
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
  # Begin of dispatch doh
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label25
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label25:
	lw	$t1 8($a0)
	lw	$t1 32($t1)
	jalr		$t1
  # End of dispatch doh
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
  # Begin of dispatch printh
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label27
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label27:
	lw	$t1 8($a0)
	lw	$t1 28($t1)
	jalr		$t1
  # End of dispatch printh
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
	sw	$a0 28($s0)
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	jr	$ra	
Razz_init:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	Foo_init
	li	$a0 0
  # Try to find self
	move	$a0 $s0
	move	$t1 $a0
	move	$a0 $s0
	bne	$zero $t1 label29
	li	$t1 1
	la	$a0 str_const0
	jal	_case_abort2
label29:
	move	$a0 $t1
	move	$t1 $a0
	sw	$t1 0($sp)
	addiu	$sp $sp -4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	sw	$t1 0($sp)
	addiu	$sp $sp -4
	lw	$t1 0($t1)
	la	$t2 Razz_protObj
	lw	$t2 0($t2)
	beq	$t1 $t2 label30
	b	label31
label30:
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 Bar_protObj
	jal	Object.copy
	jal	Bar_init
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	b	label34
label31:
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	sw	$t1 0($sp)
	addiu	$sp $sp -4
	lw	$t1 0($t1)
	la	$t2 Bar_protObj
	lw	$t2 0($t2)
	beq	$t1 $t2 label32
	b	label33
label32:
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find n
# in the 1 of $sp
	lw	$a0 4($sp)
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	b	label34
label33:
	move	$a0 $s0
	jal	_case_abort
label34:
	lw	$t3 4($sp)
	addiu	$sp $sp 4
	sw	$a0 32($s0)
	la	$a0 int_const2
  # Begin of static dispatch doh
	addiu	$sp $sp 0
  # Try to find a
# in the 6 of $s0
	lw	$a0 24($s0)
	bne	$zero $a0 label35
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label35:
	la	$t1 Bazz_dispTab
	lw	$t1 32($t1)
	jalr		$t1
  # End of static doh
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Begin of dispatch doh
	addiu	$sp $sp 0
  # Try to find g
# in the 4 of $s0
	lw	$a0 16($s0)
	bne	$zero $a0 label37
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label37:
	lw	$t1 8($a0)
	lw	$t1 32($t1)
	jalr		$t1
  # End of dispatch doh
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
  # Begin of dispatch doh
	addiu	$sp $sp 0
  # Try to find e
# in the 8 of $s0
	lw	$a0 32($s0)
	bne	$zero $a0 label39
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label39:
	lw	$t1 8($a0)
	lw	$t1 32($t1)
	jalr		$t1
  # End of dispatch doh
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
  # Begin of dispatch doh
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label41
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label41:
	lw	$t1 8($a0)
	lw	$t1 32($t1)
	jalr		$t1
  # End of dispatch doh
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
  # Begin of dispatch printh
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label43
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label43:
	lw	$t1 8($a0)
	lw	$t1 28($t1)
	jalr		$t1
  # End of dispatch printh
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
	sw	$a0 36($s0)
	move	$a0 $s0
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	jr	$ra	
Bar_init:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	Razz_init
	la	$a0 int_const2
  # Begin of dispatch doh
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label45
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label45:
	lw	$t1 8($a0)
	lw	$t1 32($t1)
	jalr		$t1
  # End of dispatch doh
	sw	$a0 40($s0)
	li	$a0 0
  # Begin of dispatch printh
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label47
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label47:
	lw	$t1 8($a0)
	lw	$t1 28($t1)
	jalr		$t1
  # End of dispatch printh
	sw	$a0 44($s0)
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
	la	$a0 str_const1
	lw	$ra 4($sp)
	addiu	$sp $sp 4
	lw	$s0 4($sp)
	addiu	$sp $sp 4
	lw	$fp 4($sp)
	addiu	$sp $sp 4
	addiu	$sp $sp 0
	jr	$ra	
Bazz.printh:
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
  # Try to find h
# in the 3 of $s0
	lw	$a0 12($s0)
	sw	$a0 4($sp)
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label49
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label49:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
  # End of dispatch out_int
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
Bazz.doh:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	la	$a0 Int_protObj
  # Try to find h
# in the 3 of $s0
	lw	$a0 12($s0)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
# Begin of Assign 
  # Try to find h
# in the 3 of $s0
	lw	$a0 12($s0)
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 int_const1
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
	sw	$a0 12($s0)
# End of Assign 
  # Try to find i
# in the 1 of $sp
	lw	$a0 4($sp)
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
Foo.doh:
	sw	$fp 0($sp)
	addiu	$sp $sp -4
	sw	$s0 0($sp)
	addiu	$sp $sp -4
	sw	$ra 0($sp)
	addiu	$sp $sp -4
	addiu	$fp $sp 4
	move	$s0 $a0
	la	$a0 Int_protObj
  # Try to find h
# in the 3 of $s0
	lw	$a0 12($s0)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
# Begin of Assign 
  # Try to find h
# in the 3 of $s0
	lw	$a0 12($s0)
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
	sw	$a0 12($s0)
# End of Assign 
  # Try to find i
# in the 1 of $sp
	lw	$a0 4($sp)
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
