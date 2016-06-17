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
str_const11:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const0
	.byte	0	
	.align	2
	.word	-1
str_const10:
	.word	3
	.word	6
	.word	String_dispTab
	.word	int_const3
	.ascii	"Main"
	.byte	0	
	.align	2
	.word	-1
str_const9:
	.word	3
	.word	6
	.word	String_dispTab
	.word	int_const4
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
	.word	int_const5
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
	.word	int_const4
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
	.word	7
	.word	String_dispTab
	.word	int_const10
	.ascii	"./not.cl"
	.byte	0	
	.align	2
	.word	-1
int_const10:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	8
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
	.word	3
	.word	-1
int_const4:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	6
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
	.word	1
	.word	-1
int_const1:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	100
	.word	-1
int_const0:
	.word	1
	.word	4
	.word	Int_dispTab
	.word	0
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
	.word	-1
Object_protObj:
	.word	0
	.word	3
	.word	Object_dispTab
	.word	-1
Main_protObj:
	.word	5
	.word	3
	.word	Main_dispTab
	.word	-1
String_protObj:
	.word	3
	.word	5
	.word	String_dispTab
	.word	int_const0
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
	la	$a0 int_const0
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
	la	$a0 Int_protObj
	la	$a0 int_const0
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 Bool_protObj
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	sw	$a0 0($sp)
	addiu	$sp $sp -4
label1:
  # Try to find x
# in the 3 of $sp
	lw	$a0 12($sp)
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
	lw	$t1 12($t1)
	lw	$t2 12($t2)
	blt	$t1 $t2 label5
label4:
	la	$a0 bool_const0
	b	label6
label5:
	la	$a0 bool_const1
label6:
	move	$t1 $a0
	la	$t2 bool_const1
	beq	$t1 $t2 label2
	b	label3
label2:
  # Try to find b
# in the 2 of $sp
	lw	$a0 8($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find b
# in the 3 of $sp
	lw	$a0 12($sp)
	lw	$t1 12($a0)
	beqz	$t1 label10
label11:
	la	$a0 bool_const0
	b	label12
label10:
	la	$a0 bool_const1
label12:
	lw	$t1 12($a0)
	beqz	$t1 label13
label14:
	la	$a0 bool_const0
	b	label15
label13:
	la	$a0 bool_const1
label15:
	lw	$t1 12($a0)
	beqz	$t1 label16
label17:
	la	$a0 bool_const0
	b	label18
label16:
	la	$a0 bool_const1
label18:
	lw	$t1 12($a0)
	beqz	$t1 label19
label20:
	la	$a0 bool_const0
	b	label21
label19:
	la	$a0 bool_const1
label21:
	lw	$t1 12($a0)
	beqz	$t1 label22
label23:
	la	$a0 bool_const0
	b	label24
label22:
	la	$a0 bool_const1
label24:
	lw	$t1 12($a0)
	beqz	$t1 label25
label26:
	la	$a0 bool_const0
	b	label27
label25:
	la	$a0 bool_const1
label27:
	lw	$t1 12($a0)
	beqz	$t1 label28
label29:
	la	$a0 bool_const0
	b	label30
label28:
	la	$a0 bool_const1
label30:
	lw	$t1 12($a0)
	beqz	$t1 label31
label32:
	la	$a0 bool_const0
	b	label33
label31:
	la	$a0 bool_const1
label33:
	lw	$t1 12($a0)
	beqz	$t1 label34
label35:
	la	$a0 bool_const0
	b	label36
label34:
	la	$a0 bool_const1
label36:
	lw	$t1 12($a0)
	beqz	$t1 label37
label38:
	la	$a0 bool_const0
	b	label39
label37:
	la	$a0 bool_const1
label39:
	lw	$t1 12($a0)
	beqz	$t1 label40
label41:
	la	$a0 bool_const0
	b	label42
label40:
	la	$a0 bool_const1
label42:
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	la	$a0 bool_const1
	la	$a1 bool_const0
	beq	$t1 $t2 label9
	jal	equality_test
	lw	$t3 12($a0)
	beqz	$t3 label7
	la	$a0 bool_const1
	b	label9
label7:
	la	$a0 bool_const0
label9:
  # Try to find b
# in the 2 of $sp
	lw	$a0 8($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find b
# in the 3 of $sp
	lw	$a0 12($sp)
	lw	$t1 12($a0)
	beqz	$t1 label46
label47:
	la	$a0 bool_const0
	b	label48
label46:
	la	$a0 bool_const1
label48:
	lw	$t1 12($a0)
	beqz	$t1 label49
label50:
	la	$a0 bool_const0
	b	label51
label49:
	la	$a0 bool_const1
label51:
	lw	$t1 12($a0)
	beqz	$t1 label52
label53:
	la	$a0 bool_const0
	b	label54
label52:
	la	$a0 bool_const1
label54:
	lw	$t1 12($a0)
	beqz	$t1 label55
label56:
	la	$a0 bool_const0
	b	label57
label55:
	la	$a0 bool_const1
label57:
	lw	$t1 12($a0)
	beqz	$t1 label58
label59:
	la	$a0 bool_const0
	b	label60
label58:
	la	$a0 bool_const1
label60:
	lw	$t1 12($a0)
	beqz	$t1 label61
label62:
	la	$a0 bool_const0
	b	label63
label61:
	la	$a0 bool_const1
label63:
	lw	$t1 12($a0)
	beqz	$t1 label64
label65:
	la	$a0 bool_const0
	b	label66
label64:
	la	$a0 bool_const1
label66:
	lw	$t1 12($a0)
	beqz	$t1 label67
label68:
	la	$a0 bool_const0
	b	label69
label67:
	la	$a0 bool_const1
label69:
	lw	$t1 12($a0)
	beqz	$t1 label70
label71:
	la	$a0 bool_const0
	b	label72
label70:
	la	$a0 bool_const1
label72:
	lw	$t1 12($a0)
	beqz	$t1 label73
label74:
	la	$a0 bool_const0
	b	label75
label73:
	la	$a0 bool_const1
label75:
	lw	$t1 12($a0)
	beqz	$t1 label76
label77:
	la	$a0 bool_const0
	b	label78
label76:
	la	$a0 bool_const1
label78:
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
  # Try to find b
# in the 2 of $sp
	lw	$a0 8($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find b
# in the 3 of $sp
	lw	$a0 12($sp)
	lw	$t1 12($a0)
	beqz	$t1 label82
label83:
	la	$a0 bool_const0
	b	label84
label82:
	la	$a0 bool_const1
label84:
	lw	$t1 12($a0)
	beqz	$t1 label85
label86:
	la	$a0 bool_const0
	b	label87
label85:
	la	$a0 bool_const1
label87:
	lw	$t1 12($a0)
	beqz	$t1 label88
label89:
	la	$a0 bool_const0
	b	label90
label88:
	la	$a0 bool_const1
label90:
	lw	$t1 12($a0)
	beqz	$t1 label91
label92:
	la	$a0 bool_const0
	b	label93
label91:
	la	$a0 bool_const1
label93:
	lw	$t1 12($a0)
	beqz	$t1 label94
label95:
	la	$a0 bool_const0
	b	label96
label94:
	la	$a0 bool_const1
label96:
	lw	$t1 12($a0)
	beqz	$t1 label97
label98:
	la	$a0 bool_const0
	b	label99
label97:
	la	$a0 bool_const1
label99:
	lw	$t1 12($a0)
	beqz	$t1 label100
label101:
	la	$a0 bool_const0
	b	label102
label100:
	la	$a0 bool_const1
label102:
	lw	$t1 12($a0)
	beqz	$t1 label103
label104:
	la	$a0 bool_const0
	b	label105
label103:
	la	$a0 bool_const1
label105:
	lw	$t1 12($a0)
	beqz	$t1 label106
label107:
	la	$a0 bool_const0
	b	label108
label106:
	la	$a0 bool_const1
label108:
	lw	$t1 12($a0)
	beqz	$t1 label109
label110:
	la	$a0 bool_const0
	b	label111
label109:
	la	$a0 bool_const1
label111:
	lw	$t1 12($a0)
	beqz	$t1 label112
label113:
	la	$a0 bool_const0
	b	label114
label112:
	la	$a0 bool_const1
label114:
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	la	$a0 bool_const1
	la	$a1 bool_const0
	beq	$t1 $t2 label81
	jal	equality_test
	lw	$t3 12($a0)
	beqz	$t3 label79
	la	$a0 bool_const1
	b	label81
label79:
	la	$a0 bool_const0
label81:
  # Try to find b
# in the 2 of $sp
	lw	$a0 8($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find b
# in the 3 of $sp
	lw	$a0 12($sp)
	lw	$t1 12($a0)
	beqz	$t1 label118
label119:
	la	$a0 bool_const0
	b	label120
label118:
	la	$a0 bool_const1
label120:
	lw	$t1 12($a0)
	beqz	$t1 label121
label122:
	la	$a0 bool_const0
	b	label123
label121:
	la	$a0 bool_const1
label123:
	lw	$t1 12($a0)
	beqz	$t1 label124
label125:
	la	$a0 bool_const0
	b	label126
label124:
	la	$a0 bool_const1
label126:
	lw	$t1 12($a0)
	beqz	$t1 label127
label128:
	la	$a0 bool_const0
	b	label129
label127:
	la	$a0 bool_const1
label129:
	lw	$t1 12($a0)
	beqz	$t1 label130
label131:
	la	$a0 bool_const0
	b	label132
label130:
	la	$a0 bool_const1
label132:
	lw	$t1 12($a0)
	beqz	$t1 label133
label134:
	la	$a0 bool_const0
	b	label135
label133:
	la	$a0 bool_const1
label135:
	lw	$t1 12($a0)
	beqz	$t1 label136
label137:
	la	$a0 bool_const0
	b	label138
label136:
	la	$a0 bool_const1
label138:
	lw	$t1 12($a0)
	beqz	$t1 label139
label140:
	la	$a0 bool_const0
	b	label141
label139:
	la	$a0 bool_const1
label141:
	lw	$t1 12($a0)
	beqz	$t1 label142
label143:
	la	$a0 bool_const0
	b	label144
label142:
	la	$a0 bool_const1
label144:
	lw	$t1 12($a0)
	beqz	$t1 label145
label146:
	la	$a0 bool_const0
	b	label147
label145:
	la	$a0 bool_const1
label147:
	lw	$t1 12($a0)
	beqz	$t1 label148
label149:
	la	$a0 bool_const0
	b	label150
label148:
	la	$a0 bool_const1
label150:
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	la	$a0 bool_const1
	la	$a1 bool_const0
	beq	$t1 $t2 label117
	jal	equality_test
	lw	$t3 12($a0)
	beqz	$t3 label115
	la	$a0 bool_const1
	b	label117
label115:
	la	$a0 bool_const0
label117:
  # Try to find b
# in the 2 of $sp
	lw	$a0 8($sp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
  # Try to find b
# in the 3 of $sp
	lw	$a0 12($sp)
	lw	$t1 12($a0)
	beqz	$t1 label154
label155:
	la	$a0 bool_const0
	b	label156
label154:
	la	$a0 bool_const1
label156:
	lw	$t1 12($a0)
	beqz	$t1 label157
label158:
	la	$a0 bool_const0
	b	label159
label157:
	la	$a0 bool_const1
label159:
	lw	$t1 12($a0)
	beqz	$t1 label160
label161:
	la	$a0 bool_const0
	b	label162
label160:
	la	$a0 bool_const1
label162:
	lw	$t1 12($a0)
	beqz	$t1 label163
label164:
	la	$a0 bool_const0
	b	label165
label163:
	la	$a0 bool_const1
label165:
	lw	$t1 12($a0)
	beqz	$t1 label166
label167:
	la	$a0 bool_const0
	b	label168
label166:
	la	$a0 bool_const1
label168:
	lw	$t1 12($a0)
	beqz	$t1 label169
label170:
	la	$a0 bool_const0
	b	label171
label169:
	la	$a0 bool_const1
label171:
	lw	$t1 12($a0)
	beqz	$t1 label172
label173:
	la	$a0 bool_const0
	b	label174
label172:
	la	$a0 bool_const1
label174:
	lw	$t1 12($a0)
	beqz	$t1 label175
label176:
	la	$a0 bool_const0
	b	label177
label175:
	la	$a0 bool_const1
label177:
	lw	$t1 12($a0)
	beqz	$t1 label178
label179:
	la	$a0 bool_const0
	b	label180
label178:
	la	$a0 bool_const1
label180:
	lw	$t1 12($a0)
	beqz	$t1 label181
label182:
	la	$a0 bool_const0
	b	label183
label181:
	la	$a0 bool_const1
label183:
	lw	$t1 12($a0)
	beqz	$t1 label184
label185:
	la	$a0 bool_const0
	b	label186
label184:
	la	$a0 bool_const1
label186:
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$t2 4($sp)
	addiu	$sp $sp 4
	lw	$t1 4($sp)
	addiu	$sp $sp 4
	la	$a0 bool_const1
	la	$a1 bool_const0
	beq	$t1 $t2 label153
	jal	equality_test
	lw	$t3 12($a0)
	beqz	$t3 label151
	la	$a0 bool_const1
	b	label153
label151:
	la	$a0 bool_const0
label153:
# Begin of Assign 
  # Try to find x
# in the 3 of $sp
	lw	$a0 12($sp)
	jal	Object.copy
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 int_const2
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
	sw	$a0 12($sp)
# End of Assign 
	b	label1
label3:
	lw	$a0 4($sp)
	addiu	$sp $sp 4
  # Try to find b
# in the 1 of $sp
	lw	$a0 4($sp)
	move	$t1 $a0
	la	$t2 bool_const1
	beq	$t1 $t2 label188
label187:
	la	$a0 int_const0
	jal	Object.copy
	b	label189
label188:
  # Begin of dispatch abort
	addiu	$sp $sp 0
  # Try to find self
	move	$a0 $s0
	bne	$zero $a0 label190
	li	$t1 1
	la	$a0 str_const0
	jal	_dispatch_abort
label190:
	lw	$t1 8($a0)
	lw	$t1 0($t1)
	jalr		$t1
  # End of dispatch abort
label189:
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
