
//**************************************************************
//
// Code generator SKELETON
//
// Read the comments carefully. Make sure to
//    initialize the base class tags in
//       `CgenClassTable::CgenClassTable'
//
//    Add the label for the dispatch tables to
//       `IntEntry::code_def'
//       `StringEntry::code_def'
//       `BoolConst::code_def'
//
//    Add code to emit everyting else that is needed
//       in `CgenClassTable::code'
//
//
// The files as provided will produce code to begin the code
// segments, declare globals, and emit constants.  You must
// fill in the rest.
//
//**************************************************************

#include "cgen.h"
#include "cgen_gc.h"

extern void emit_string_constant(ostream& str, char *s);
extern int cgen_debug;

//
// Three symbols from the semantic analyzer (semant.cc) are used.
// If e : No_type, then no code is generated for e.
// Special code is generated for new SELF_TYPE.
// The name "self" also generates code different from other references.
//
//////////////////////////////////////////////////////////////////////
//
// Symbols
//
// For convenience, a large number of symbols are predefined here.
// These symbols include the primitive type and method names, as well
// as fixed names used by the runtime system.
//
//////////////////////////////////////////////////////////////////////
Symbol
arg,
  arg2,
  Bool,
  concat,
  cool_abort,
  copy,
  Int,
  in_int,
  in_string,
  IO,
  length,
  Main,
  main_meth,
  No_class,
  No_type,
  Object,
  out_int,
  out_string,
  prim_slot,
  self,
  SELF_TYPE,
  Str,
  str_field,
  substr,
  type_name,
  val;

char *int_init_const, *str_init_const, *bool_init_const;
char object_copy_method[] = "Object.copy";

//
// Initializing the predefined symbols.
//
static void initialize_constants(void)
{
  arg         = idtable.add_string("arg");
  arg2        = idtable.add_string("arg2");
  Bool        = idtable.add_string("Bool");
  concat      = idtable.add_string("concat");
  cool_abort  = idtable.add_string("abort");
  copy        = idtable.add_string("copy");
  Int         = idtable.add_string("Int");
  in_int      = idtable.add_string("in_int");
  in_string   = idtable.add_string("in_string");
  IO          = idtable.add_string("IO");
  length      = idtable.add_string("length");
  Main        = idtable.add_string("Main");
  main_meth   = idtable.add_string("main");
  //   _no_class is a symbol that can't be the name of any
  //   user-defined class.
  No_class    = idtable.add_string("_no_class");
  No_type     = idtable.add_string("_no_type");
  Object      = idtable.add_string("Object");
  out_int     = idtable.add_string("out_int");
  out_string  = idtable.add_string("out_string");
  prim_slot   = idtable.add_string("_prim_slot");
  self        = idtable.add_string("self");
  SELF_TYPE   = idtable.add_string("SELF_TYPE");
  Str         = idtable.add_string("String");
  str_field   = idtable.add_string("_str_field");
  substr      = idtable.add_string("substr");
  type_name   = idtable.add_string("type_name");
  val         = idtable.add_string("_val");
}

static char *gc_init_names[] =
{ "_NoGC_Init", "_GenGC_Init", "_ScnGC_Init" };
static char *gc_collect_names[] =
{ "_NoGC_Collect", "_GenGC_Collect", "_ScnGC_Collect" };


//  BoolConst is a class that implements code generation for operations
//  on the two booleans, which are given global names here.
BoolConst falsebool(FALSE);
BoolConst truebool(TRUE);


//*********************************************************
//
// Define method for code generation
//
// This is the method called by the compiler driver
// `cgtest.cc'. cgen takes an `ostream' to which the assembly will be
// emmitted, and it passes this and the class list of the
// code generator tree to the constructor for `CgenClassTable'.
// That constructor performs all of the work of the code
// generator.
//
//*********************************************************

void program_class::cgen(ostream &os)
{

  initialize_constants();
  CgenClassTable *codegen_classtable = new CgenClassTable(classes,os);

}


//////////////////////////////////////////////////////////////////////////////
//
//  emit_* procedures
//
//  emit_X  writes code for operation "X" to the output stream.
//  There is an emit_X for each opcode X, as well as emit_ functions
//  for generating names according to the naming conventions (see emit.h)
//  and calls to support functions defined in the trap handler.
//
//  Register names and addresses are passed as strings.  See `emit.h'
//  for symbolic names you can use to refer to the strings.
//
//////////////////////////////////////////////////////////////////////////////

static void emit_load(char *dest_reg, int offset, char *source_reg, ostream& s)
{
  s << LW << dest_reg << " " << offset * WORD_SIZE << "(" << source_reg << ")"
    << endl;
}

static void emit_store(char *source_reg, int offset, char *dest_reg, ostream& s)
{
  s << SW << source_reg << " " << offset * WORD_SIZE << "(" << dest_reg << ")"
    << endl;
}

static void emit_load_imm(char *dest_reg, int val, ostream& s)
{ s << LI << dest_reg << " " << val << endl; }

static void emit_load_address(char *dest_reg, char *address, ostream& s)
{ s << LA << dest_reg << " " << address << endl; }

static void emit_partial_load_address(char *dest_reg, ostream& s)
{ s << LA << dest_reg << " "; }

static void emit_load_bool(char *dest, const BoolConst& b, ostream& s)
{
  emit_partial_load_address(dest,s);
  b.code_ref(s);
  s << endl;
}

static void emit_load_string(char *dest, StringEntry *str, ostream& s)
{
  emit_partial_load_address(dest,s);
  str->code_ref(s);
  s << endl;
}

static void emit_load_int(char *dest, IntEntry *i, ostream& s)
{
  emit_partial_load_address(dest,s);
  i->code_ref(s);
  s << endl;
}

static void emit_move(char *dest_reg, char *source_reg, ostream& s)
{ s << MOVE << dest_reg << " " << source_reg << endl; }

static void emit_neg(char *dest, char *src1, ostream& s)
{ s << NEG << dest << " " << src1 << endl; }

static void emit_add(char *dest, char *src1, char *src2, ostream& s)
{ s << ADD << dest << " " << src1 << " " << src2 << endl; }

static void emit_addu(char *dest, char *src1, char *src2, ostream& s)
{ s << ADDU << dest << " " << src1 << " " << src2 << endl; }

static void emit_addiu(char *dest, char *src1, int imm, ostream& s)
{ s << ADDIU << dest << " " << src1 << " " << imm << endl; }

static void emit_div(char *dest, char *src1, char *src2, ostream& s)
{ s << DIV << dest << " " << src1 << " " << src2 << endl; }

static void emit_mul(char *dest, char *src1, char *src2, ostream& s)
{ s << MUL << dest << " " << src1 << " " << src2 << endl; }

static void emit_sub(char *dest, char *src1, char *src2, ostream& s)
{ s << SUB << dest << " " << src1 << " " << src2 << endl; }

static void emit_sll(char *dest, char *src1, int num, ostream& s)
{ s << SLL << dest << " " << src1 << " " << num << endl; }

static void emit_jalr(char *dest, ostream& s)
{ s << JALR << "\t" << dest << endl; }

static void emit_jal(char *address,ostream &s)
{ s << JAL << address << endl; }

static void emit_return(ostream& s)
{ s << RET << endl; }

static void emit_gc_assign(ostream& s)
{ s << JAL << "_GenGC_Assign" << endl; }

static void emit_disptable_ref(Symbol sym, ostream& s)
{  s << sym << DISPTAB_SUFFIX; }

static void emit_init_ref(Symbol sym, ostream& s)
{ s << sym << CLASSINIT_SUFFIX; }

static void emit_label_ref(int l, ostream &s)
{ s << "label" << l; }

static void emit_protobj_ref(Symbol sym, ostream& s)
{ s << sym << PROTOBJ_SUFFIX; }

static void emit_method_ref(Symbol classname, Symbol methodname, ostream& s)
{ s << classname << METHOD_SEP << methodname; }

static void emit_label_def(int l, ostream &s)
{
  emit_label_ref(l,s);
  s << ":" << endl;
}

static void emit_beqz(char *source, int label, ostream &s)
{
  s << BEQZ << source << " ";
  emit_label_ref(label,s);
  s << endl;
}

static void emit_beq(char *src1, char *src2, int label, ostream &s)
{
  s << BEQ << src1 << " " << src2 << " ";
  emit_label_ref(label,s);
  s << endl;
}

static void emit_bne(char *src1, char *src2, int label, ostream &s)
{
  s << BNE << src1 << " " << src2 << " ";
  emit_label_ref(label,s);
  s << endl;
}

static void emit_bleq(char *src1, char *src2, int label, ostream &s)
{
  s << BLEQ << src1 << " " << src2 << " ";
  emit_label_ref(label,s);
  s << endl;
}

static void emit_blt(char *src1, char *src2, int label, ostream &s)
{
  s << BLT << src1 << " " << src2 << " ";
  emit_label_ref(label,s);
  s << endl;
}

static void emit_blti(char *src1, int imm, int label, ostream &s)
{
  s << BLT << src1 << " " << imm << " ";
  emit_label_ref(label,s);
  s << endl;
}

static void emit_bgti(char *src1, int imm, int label, ostream &s)
{
  s << BGT << src1 << " " << imm << " ";
  emit_label_ref(label,s);
  s << endl;
}

static void emit_branch(int l, ostream& s)
{
  s << BRANCH;
  emit_label_ref(l,s);
  s << endl;
}

//
// Push a register on the stack. The stack grows towards smaller addresses.
//
static void emit_push(char *reg, ostream& str)
{
  emit_store(reg,0,SP,str);
  emit_addiu(SP,SP,-4,str);
}

//
// Fetch the integer value in an Int object.
// Emits code to fetch the integer value of the Integer object pointed
// to by register source into the register dest
//
static void emit_fetch_int(char *dest, char *source, ostream& s)
{ emit_load(dest, DEFAULT_OBJFIELDS, source, s); }

//
// Emits code to store the integer value contained in register source
// into the Integer object pointed to by dest.
//
static void emit_store_int(char *source, char *dest, ostream& s)
{ emit_store(source, DEFAULT_OBJFIELDS, dest, s); }


static void emit_test_collector(ostream &s)
{
  emit_push(ACC, s);
  emit_move(ACC, SP, s); // stack end
  emit_move(A1, ZERO, s); // allocate nothing
  s << JAL << gc_collect_names[cgen_Memmgr] << endl;
  emit_addiu(SP,SP,4,s);
  emit_load(ACC,0,SP,s);
}

static void emit_gc_check(char *source, ostream &s)
{
  if (source != (char*)A1) emit_move(A1, source, s);
  s << JAL << "_gc_check" << endl;
}


///////////////////////////////////////////////////////////////////////////////
//
// coding strings, ints, and booleans
//
// Cool has three kinds of constants: strings, ints, and booleans.
// This section defines code generation for each type.
//
// All string constants are listed in the global "stringtable" and have
// type StringEntry.  StringEntry methods are defined both for String
// constant definitions and references.
//
// All integer constants are listed in the global "inttable" and have
// type IntEntry.  IntEntry methods are defined for Int
// constant definitions and references.
//
// Since there are only two Bool values, there is no need for a table.
// The two booleans are represented by instances of the class BoolConst,
// which defines the definition and reference methods for Bools.
//
///////////////////////////////////////////////////////////////////////////////

//
// Strings
//
void StringEntry::code_ref(ostream& s)
{
  s << STRCONST_PREFIX << index;
}

//
// Emit code for a constant String.
// You should fill in the code naming the dispatch table.
//

void StringEntry::code_def(ostream& s, int stringclasstag)
{
  IntEntryP lensym = inttable.add_int(len);

  // Add -1 eye catcher
  s << WORD << "-1" << endl;

  code_ref(s);  s  << LABEL                                             // label
    << WORD << stringclasstag << endl                                 // tag
    << WORD << (DEFAULT_OBJFIELDS + STRING_SLOTS + (len+4)/4) << endl // size
    << WORD;


  /***** Add dispatch information for class String ******/

  s << STRINGNAME << DISPTAB_SUFFIX << endl;              // dispatch table
  s << WORD;  lensym->code_ref(s);  s << endl;            // string length
  emit_string_constant(s,str);                                // ascii string
  s << ALIGN;                                                 // align to word
}

//
// StrTable::code_string
// Generate a string object definition for every string constant in the
// stringtable.
//
void StrTable::code_string_table(ostream& s, int stringclasstag)
{
  for (List<StringEntry> *l = tbl; l; l = l->tl())
    l->hd()->code_def(s,stringclasstag);
}

//
// Ints
//
void IntEntry::code_ref(ostream &s)
{
  s << INTCONST_PREFIX << index;
}

//
// Emit code for a constant Integer.
// You should fill in the code naming the dispatch table.
//

void IntEntry::code_def(ostream &s, int intclasstag)
{
  // Add -1 eye catcher
  s << WORD << "-1" << endl;

  code_ref(s);  s << LABEL                                // label
    << WORD << intclasstag << endl                      // class tag
    << WORD << (DEFAULT_OBJFIELDS + INT_SLOTS) << endl  // object size
    << WORD;

  /***** Add dispatch information for class Int ******/

  s << INTNAME << DISPTAB_SUFFIX << endl;             // dispatch table
  s << WORD << str << endl;                           // integer value
}


//
// IntTable::code_string_table
// Generate an Int object definition for every Int constant in the
// inttable.
//
void IntTable::code_string_table(ostream &s, int intclasstag)
{
  for (List<IntEntry> *l = tbl; l; l = l->tl())
    l->hd()->code_def(s,intclasstag);
}

//
// Bools
//
BoolConst::BoolConst(int i) : val(i) { assert(i == 0 || i == 1); }

void BoolConst::code_ref(ostream& s) const
{
  s << BOOLCONST_PREFIX << val;
}

//
// Emit code for a constant Bool.
// You should fill in the code naming the dispatch table.
//

void BoolConst::code_def(ostream& s, int boolclasstag)
{
  // Add -1 eye catcher
  s << WORD << "-1" << endl;

  code_ref(s);  s << LABEL                                  // label
    << WORD << boolclasstag << endl                       // class tag
    << WORD << (DEFAULT_OBJFIELDS + BOOL_SLOTS) << endl   // object size
    << WORD;

  /***** Add dispatch information for class Bool ******/

  s << BOOLNAME << DISPTAB_SUFFIX << endl;              // dispatch table
  s << WORD << val << endl;                             // value (0 or 1)
}

//////////////////////////////////////////////////////////////////////////////
//
//  My defined methods
//
//////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////
//
//  CgenClassTable methods
//
//////////////////////////////////////////////////////////////////////////////

//***************************************************
//
//  Emit code to start the .data segment and to
//  declare the global names.
//
//***************************************************

void CgenClassTable::code_global_data()
{
  Symbol main    = idtable.lookup_string(MAINNAME);
  Symbol string  = idtable.lookup_string(STRINGNAME);
  Symbol integer = idtable.lookup_string(INTNAME);
  Symbol boolc   = idtable.lookup_string(BOOLNAME);

  str << "\t.data\n" << ALIGN;
  //
  // The following global names must be defined first.
  //
  str << GLOBAL << CLASSNAMETAB << endl;
  str << GLOBAL; emit_protobj_ref(main,str);    str << endl;
  str << GLOBAL; emit_protobj_ref(integer,str); str << endl;
  str << GLOBAL; emit_protobj_ref(string,str);  str << endl;
  str << GLOBAL; falsebool.code_ref(str);  str << endl;
  str << GLOBAL; truebool.code_ref(str);   str << endl;
  str << GLOBAL << INTTAG << endl;
  str << GLOBAL << BOOLTAG << endl;
  str << GLOBAL << STRINGTAG << endl;

  //
  // We also need to know the tag of the Int, String, and Bool classes
  // during code generation.
  //
  str << INTTAG << LABEL
    << WORD << intclasstag << endl;
  str << BOOLTAG << LABEL
    << WORD << boolclasstag << endl;
  str << STRINGTAG << LABEL
    << WORD << stringclasstag << endl;
}


//***************************************************
//
//  Emit code to start the .text segment and to
//  declare the global names.
//
//***************************************************

void CgenClassTable::code_global_text()
{
  str << GLOBAL << HEAP_START << endl
    << HEAP_START << LABEL
    << WORD << 0 << endl
    << "\t.text" << endl
    << GLOBAL;
  emit_init_ref(idtable.add_string("Main"), str);
  str << endl << GLOBAL;
  emit_init_ref(idtable.add_string("Int"),str);
  str << endl << GLOBAL;
  emit_init_ref(idtable.add_string("String"),str);
  str << endl << GLOBAL;
  emit_init_ref(idtable.add_string("Bool"),str);
  str << endl << GLOBAL;
  emit_method_ref(idtable.add_string("Main"), idtable.add_string("main"), str);
  str << endl;
}

void CgenClassTable::code_bools(int boolclasstag)
{
  falsebool.code_def(str,boolclasstag);
  truebool.code_def(str,boolclasstag);
}

void CgenClassTable::code_select_gc()
{
  //
  // Generate GC choice constants (pointers to GC functions)
  //
  str << GLOBAL << "_MemMgr_INITIALIZER" << endl;
  str << "_MemMgr_INITIALIZER:" << endl;
  str << WORD << gc_init_names[cgen_Memmgr] << endl;
  str << GLOBAL << "_MemMgr_COLLECTOR" << endl;
  str << "_MemMgr_COLLECTOR:" << endl;
  str << WORD << gc_collect_names[cgen_Memmgr] << endl;
  str << GLOBAL << "_MemMgr_TEST" << endl;
  str << "_MemMgr_TEST:" << endl;
  str << WORD << (cgen_Memmgr_Test == GC_TEST) << endl;
}


//********************************************************
//
// Emit code to reserve space for and initialize all of
// the constants.  Class names should have been added to
// the string table (in the supplied code, is is done
// during the construction of the inheritance graph), and
// code for emitting string constants as a side effect adds
// the string's length to the integer table.  The constants
// are emmitted by running through the stringtable and inttable
// and producing code for each entry.
//
//********************************************************

void CgenClassTable::code_constants()
{
  //
  // Add constants that are required by the code generator.
  //
  stringtable.add_string("");
  inttable.add_string("0");

  stringtable.code_string_table(str,stringclasstag);
  inttable.code_string_table(str,intclasstag);
  code_bools(boolclasstag);

  std::stringstream stream_buffer1, stream_buffer2, stream_buffer3;
  inttable.lookup_string("0")->code_ref(stream_buffer1);
  int_init_const = strdup(stream_buffer1.str().c_str());
  stringtable.lookup_string("")->code_ref(stream_buffer2);
  str_init_const = strdup(stream_buffer2.str().c_str());
  bool_init_const = strdup("bool_const0");
}


CgenClassTable::CgenClassTable(Classes classes, ostream& s) : nds(NULL) , str(s)
{

  objectclasstag = 0;
  intclasstag =    1 /* Change to your Int class tag here */;
  boolclasstag =   2 /* Change to your Bool class tag here */;
  stringclasstag = 3 /* Change to your String class tag here */;
  ioclasstag = 4 /* Change to your String class tag here */;
  tag_count = 4;
  cgen_env = new VariableEnvironment();

  cgen_env->enterscope();
  enterscope();
  if (cgen_debug) cout << "Building CgenClassTable" << endl;
  install_basic_classes();
  install_classes(classes);
  build_inheritance_tree();

  code();
  exitscope();
  cgen_env->exitscope();
}

void CgenClassTable::install_basic_classes()
{

  // The tree package uses these globals to annotate the classes built below.
  //curr_lineno  = 0;
  Symbol filename = stringtable.add_string("<basic class>");

  //
  // A few special class names are installed in the lookup table but not
  // the class list.  Thus, these classes exist, but are not part of the
  // inheritance hierarchy.
  // No_class serves as the parent of Object and the other special classes.
  // SELF_TYPE is the self class; it cannot be redefined or inherited.
  // prim_slot is a class known to the code generator.
  //
  addid(No_class,
      new CgenNode(class_(No_class,No_class,nil_Features(),filename),
        Basic,this));
  addid(SELF_TYPE,
      new CgenNode(class_(SELF_TYPE,No_class,nil_Features(),filename),
        Basic,this));
  addid(prim_slot,
      new CgenNode(class_(prim_slot,No_class,nil_Features(),filename),
        Basic,this));

  //
  // The Object class has no parent class. Its methods are
  //        cool_abort() : Object    aborts the program
  //        type_name() : Str        returns a string representation of class name
  //        copy() : SELF_TYPE       returns a copy of the object
  //
  // There is no need for method bodies in the basic classes---these
  // are already built in to the runtime system.
  //
  install_class(
      new CgenNode(
        class_(Object,
          No_class,
          append_Features(
            append_Features(
              single_Features(method(cool_abort, nil_Formals(), Object, no_expr())),
              single_Features(method(type_name, nil_Formals(), Str, no_expr()))),
            single_Features(method(copy, nil_Formals(), SELF_TYPE, no_expr()))),
          filename),
        Basic,this));

  //
  // The IO class inherits from Object. Its methods are
  //        out_string(Str) : SELF_TYPE          writes a string to the output
  //        out_int(Int) : SELF_TYPE               "    an int    "  "     "
  //        in_string() : Str                    reads a string from the input
  //        in_int() : Int                         "   an int     "  "     "
  //
  install_class(
      new CgenNode(
        class_(IO,
          Object,
          append_Features(
            append_Features(
              append_Features(
                single_Features(method(out_string, single_Formals(formal(arg, Str)),
                    SELF_TYPE, no_expr())),
                single_Features(method(out_int, single_Formals(formal(arg, Int)),
                    SELF_TYPE, no_expr()))),
              single_Features(method(in_string, nil_Formals(), Str, no_expr()))),
            single_Features(method(in_int, nil_Formals(), Int, no_expr()))),
          filename),	
        Basic,this));

  //
  // The Int class has no methods and only a single attribute, the
  // "val" for the integer.
  //
  install_class(
      new CgenNode(
        class_(Int,
          Object,
          single_Features(attr(val, prim_slot, no_expr())),
          filename),
        Basic,this));

  //
  // Bool also has only the "val" slot.
  //
  install_class(
      new CgenNode(
        class_(Bool, Object, single_Features(attr(val, prim_slot, no_expr())),filename),
        Basic,this));

  //
  // The class Str has a number of slots and operations:
  //       val                                  ???
  //       str_field                            the string itself
  //       length() : Int                       length of the string
  //       concat(arg: Str) : Str               string concatenation
  //       substr(arg: Int, arg2: Int): Str     substring
  //
  install_class(
      new CgenNode(
        class_(Str,
          Object,
          append_Features(
            append_Features(
              append_Features(
                append_Features(
                  single_Features(attr(val, Int, no_expr())),
                  single_Features(attr(str_field, prim_slot, no_expr()))),
                single_Features(method(length, nil_Formals(), Int, no_expr()))),
              single_Features(method(concat,
                  single_Formals(formal(arg, Str)),
                  Str,
                  no_expr()))),
            single_Features(method(substr,
                append_Formals(single_Formals(formal(arg, Int)),
                  single_Formals(formal(arg2, Int))),
                Str,
                no_expr()))),
          filename),
        Basic,this));

}

// CgenClassTable::install_class
// CgenClassTable::install_classes
//
// install_classes enters a list of classes in the symbol table.
//
void CgenClassTable::install_class(CgenNodeP nd)
{
  Symbol name = nd->get_name();

  if (probe(name))
  {
    return;
  }

  // The class name is legal, so add it to the list of classes
  // and the symbol table.
  nds = new List<CgenNode>(nd,nds);
  addid(name,nd);

  if(nd->get_name() == Object)
    nd->set_tag(objectclasstag);
  else if(nd->get_name() == Int)
    nd->set_tag(intclasstag);
  else if(nd->get_name() == Bool)
    nd->set_tag(boolclasstag);
  else if(nd->get_name() == Str)
    nd->set_tag(stringclasstag);
  else if(nd->get_name() == IO)
    nd->set_tag(ioclasstag);
  else
    nd->set_tag(assign_tag());

  nd->init_string = (char*)malloc(strlen(nd->get_name()->get_string()) + 20);
  nd->prot_string = (char*)malloc(strlen(nd->get_name()->get_string()) + 20);
  nd->disp_string = (char*)malloc(strlen(nd->get_name()->get_string()) + 20);
  sprintf(nd->init_string, "%s%s", nd->get_name()->get_string(), CLASSINIT_SUFFIX);
  sprintf(nd->prot_string, "%s%s", nd->get_name()->get_string(), PROTOBJ_SUFFIX);
  sprintf(nd->disp_string, "%s%s", nd->get_name()->get_string(), DISPTAB_SUFFIX);

  cgen_env->addid_typ(name, new Symbol(name));
}

void CgenClassTable::install_classes(Classes cs)
{
  for(int i = cs->first(); cs->more(i); i = cs->next(i))
    install_class(new CgenNode(cs->nth(i),NotBasic,this));
}

//
// CgenClassTable::build_inheritance_tree
//
void CgenClassTable::build_inheritance_tree()
{
  for(List<CgenNode> *l = nds; l; l = l->tl())
    set_relations(l->hd());
}

//
// CgenClassTable::set_relations
//
// Takes a CgenNode and locates its, and its parent's, inheritance nodes
// via the class table.  Parent and child pointers are added as appropriate.
//
void CgenClassTable::set_relations(CgenNodeP nd)
{
  CgenNode *parent_node = probe(nd->get_parent());
  nd->set_parentnd(parent_node);
  parent_node->add_child(nd);
}

Symbol CgenClassTable::LCA(Symbol T_1, Symbol T_2)
{
  SymbolVector a1, a2;
  for(CgenNodeP itr = lookup(T_1); ; itr = itr->get_parentnd()){
    a1.push_back(itr->get_name());
    if(itr->get_name() == Object) break;
  }
  for(CgenNodeP itr = lookup(T_2); ; itr = itr->get_parentnd()){
    a2.push_back(itr->get_name());
    if(itr->get_name() == Object) break;
  }
  Symbol last_type = Object;
  for(last_type = Object; int(a1.size()) && int(a2.size()) && a1.back() == a2.back(); a1.pop_back(), a2.pop_back())
    last_type = a1.back();

  return last_type;
}

void CgenNode::add_child(CgenNodeP n)
{
  children = new List<CgenNode>(n,children);
}

void CgenNode::set_parentnd(CgenNodeP p)
{
  assert(parentnd == NULL);
  assert(p != NULL);
  parentnd = p;
}


Symbol CgenClassTable::code()
{
  if (cgen_debug) cout << "coding global data" << endl;
  code_global_data();

  if (cgen_debug) cout << "choosing gc" << endl;
  code_select_gc();

  if (cgen_debug) cout << "coding constants" << endl;
  code_constants();

  code_nameTab();
  code_objTab();
  code_layout();
  code_dispTab();
  code_protTab();

  if (cgen_debug) cout << "coding global text" << endl;
  code_global_text();

  code_objInit();
  code_classMethod();

  return Object;
}


CgenNodeP CgenClassTable::root()
{
  return probe(Object);
}

CgenNodeP CgenClassTable::class_with_tag(int x){
  for(List<CgenNode> *l = nds; l; l = l->tl())
    if(l->hd()->get_tag() == x)
      return (CgenNodeP)(l->hd());
  return NULL;
}

void CgenClassTable::code_nameTab()
{
  str << CLASSNAMETAB << LABEL;
  for(int i = 0; i <= tag_count; i++){
    CgenNodeP itr = class_with_tag(i);
    for(int j = stringtable.first(); stringtable.more(j); j = stringtable.next(j)){
      if(stringtable.lookup_string(itr->get_name()->get_string()) == (stringtable.lookup(j))){
        str << WORD;
        (stringtable.lookup(j)->code_ref(str));
        str << endl;
      }
    }
  }
}

void CgenClassTable::code_objTab()
{
  str << CLASSOBJTAB << LABEL;
  for(int i = 0; i <= tag_count; i++){
    CgenNodeP itr = class_with_tag(i);
    str << WORD << itr->prot_string << endl;
    str << WORD << itr->init_string << endl;
  }
}

void CgenClassTable::code_layout()
{
  std::stack<CgenNodeP> stk;
  stk.push(root());

  while(!stk.empty()){
    CgenNodeP itr = stk.top();
    stk.pop();
    for(List<CgenNode> *l = itr->get_children(); l; l = l->tl())
      stk.push(l->hd());

    itr->code_layout();
  }
}

void CgenNode::code_layout()
{
  attr = parentnd->attr;
  method = parentnd->method;

  for(int i = features->first(); features->more(i); i = features->next(i))
    features->nth(i)->code_layout(attr, method, this);

  set_obj_size(3 + int(attr.size()));

  for(int i = 0; i < int(method.size()); i++)
    method_dynamic_return_type.push_back(method[i].second->get_type());
}

void attr_class::code_layout(AttrVector &attr_array, MethodVector &method_array, CgenNode *nd)
{
  attr_array.push_back(this);
}

void method_class::code_layout(AttrVector &attr_array, MethodVector &method_array, CgenNode *nd)
{
  int ind = nd->index_of_method_with_name(name);
  if(ind == -1)
    method_array.push_back(ClassMethodPair(nd, this));
  else
    method_array[ind] = ClassMethodPair(nd, this);
}

void CgenClassTable::code_dispTab()
{
  std::stack<CgenNodeP> stk;
  stk.push(root());

  while(!stk.empty()){
    CgenNodeP itr = stk.top();
    stk.pop();
    for(List<CgenNode> *l = itr->get_children(); l; l = l->tl())
      stk.push(l->hd());

    str << itr->get_name() << DISPTAB_SUFFIX << LABEL;
    for(int i = 0; i < int(itr->method.size()); i++)
      str << WORD << itr->method[i].first->get_name() << '.' << itr->method[i].second->get_name() << endl;
  }
}

void CgenClassTable::code_protTab()
{
  std::stack<CgenNodeP> stk;
  stk.push(root());

  while(!stk.empty()){
    CgenNodeP itr = stk.top();
    stk.pop();
    for(List<CgenNode> *l = itr->get_children(); l; l = l->tl())
      stk.push(l->hd());

    str << WORD << "-1" << endl;
    str << itr->prot_string << LABEL;
    str << WORD << itr->get_tag() << endl;
    str << WORD << itr->get_obj_size() << endl;
    str << WORD << itr->get_name() << DISPTAB_SUFFIX << endl;
    for(int i = 0; i < int(itr->attr.size()); i++){
      if(itr->attr[i]->get_type() == Int)
        str << WORD << int_init_const << endl;
      else if(itr->attr[i]->get_type() == Bool)
        str << WORD << bool_init_const << endl;
      else if(itr->attr[i]->get_type() == Str)
        str << WORD << str_init_const  << endl;
      else
        str << WORD << EMPTYSLOT << endl;
    }
  }
}

void CgenClassTable::code_objInit()
{
  std::queue<CgenNodeP> obj_queue;
  obj_queue.push(root());

  while(!obj_queue.empty()){
    CgenNodeP nd = obj_queue.front();
    obj_queue.pop();
    for(List<CgenNode> *l = nd->get_children(); l; l = l->tl())
      obj_queue.push(l->hd());

    str << nd->init_string << LABEL;

    cgen_env->enterscope();
    cgen_env->import_class_formal(nd, cgen_env, this, str);

    cgen_env->push_reg_into_stack(No_type, FP, nd, cgen_env, this, str);
    cgen_env->push_reg_into_stack(No_type, SELF, nd, cgen_env, this, str);
    cgen_env->push_reg_into_stack(No_type, RA, nd, cgen_env, this, str);

    emit_addiu(FP, SP, 4, str);
    emit_move(SELF, ACC, str);

    if(nd->get_name() != Object)
      emit_jal(nd->get_parentnd()->init_string, str);

    for(int i = (nd==root()?0:nd->get_parentnd()->attr.size()); i < int(nd->attr.size()); i++){
      Symbol type_decl = nd->attr[i]->get_type();
      if(type_decl == Int)
        emit_load_address(ACC, int_init_const, str);
      else if(type_decl ==  Bool)
        emit_load_address(ACC, bool_init_const, str);
      else if(type_decl == Str)
        emit_load_address(ACC, str_init_const, str);
      else
        emit_load_imm(ACC, 0, str);
      nd->attr[i]->get_init()->code(nd, cgen_env, this, str);
      emit_store(ACC, i + 3, SELF, str);
    }

    emit_move(ACC, SELF, str);
    cgen_env->pop_stack(RA, nd, cgen_env, this, str);
    cgen_env->pop_stack(SELF, nd, cgen_env, this, str);
    cgen_env->pop_stack(FP, nd, cgen_env, this, str);
    emit_return(str);

    cgen_env->exitscope();
  }
}

void CgenClassTable::code_classMethod()
{
  CgenClassTable *cctable = this;

  std::stack<CgenNodeP> stk;
  stk.push(root());

  while(!stk.empty()){
    CgenNodeP itr = stk.top();
    stk.pop();
    for(List<CgenNode> *l = itr->get_children(); l; l = l->tl())
      stk.push(l->hd());

    cgen_env->enterscope();
    cgen_env->import_class_formal(itr, cgen_env, cctable, str);

    for(int i = 0; itr->basic()==0 && i < int(itr->method.size()); i++){
      method_class *m_nd = itr->method[i].second;

      if(itr->method[i].first->get_name() != itr->get_name()){
        itr->method_dynamic_return_type[i] = itr->get_parentnd()->method_dynamic_return_type[i];
        continue;
      }

      str << itr->get_name() << '.' << m_nd->get_name() << LABEL;
      Symbol ret_type = m_nd->code(itr, cgen_env, cctable, str);
      itr->method_dynamic_return_type[i] = ret_type;
    }
    cgen_env->exitscope();
  }
}

Symbol method_class::code(CgenParameter)
{
  int parameter_size = formals->len();
  cgen_env->push_reg_into_stack(No_type, FP, CgenParameterInstance);
  cgen_env->push_reg_into_stack(No_type, SELF, CgenParameterInstance);
  cgen_env->push_reg_into_stack(No_type, RA, CgenParameterInstance);

  emit_addiu(FP, SP, 4, s);
  emit_move(SELF, ACC, s);

  int method_stack_base = cgen_env->get_stack_base();
  cgen_env->enterscope();
  for(int i = formals->first(); formals->more(i); i = formals->next(i)){
    int base = cgen_env->get_stack_base();
    formal_class *itr = (formal_class*)formals->nth(i);
    cgen_env->addid_env(itr->get_name(), new Location(SP, base - 4 -i));
    cgen_env->addid_typ(itr->get_name(), new Symbol(itr->get_type()));
  }

//  cout << name << endl;
//  cgen_env->dump_env();
  Symbol ret_type = expr->code(CgenParameterInstance);
  cgen_env->exitscope();
  //assert(cgen_env->get_stack_base() == method_stack_base);

  cgen_env->pop_stack(RA, CgenParameterInstance);
  cgen_env->pop_stack(SELF, CgenParameterInstance);
  cgen_env->pop_stack(FP, CgenParameterInstance);
  cgen_env->free_stack(true, parameter_size, CgenParameterInstance);
//  cout << cgen_env->get_stack_base() << endl;

  emit_return(s);

  return ret_type;
}

///////////////////////////////////////////////////////////////////////
//
// CgenNode methods
//
///////////////////////////////////////////////////////////////////////

CgenNode::CgenNode(Class_ nd, Basicness bstatus, CgenClassTableP ct) :
  class__class((const class__class &) *nd),
  parentnd(NULL),
  children(NULL),
  basic_status(bstatus)
{
  stringtable.add_string(name->get_string());          // Add class name to string table
}

int CgenNode::index_of_attr_with_name(Symbol name)
{
  for(int i=0; i < int(attr.size()); i++)
    if(attr[i]->get_name() == name)
      return i;

  return -1;
}

int CgenNode::index_of_method_with_name(Symbol name)
{
  for(int i=0; i < int(method.size()); i++)
    if(method[i].second->get_name() == name)
      return i;

  return -1;
}

attr_class* CgenNode::attr_at_index(int idx)
{
  assert(idx < int(attr.size()));
  return attr[idx];
}

attr_class* CgenNode::attr_with_name(Symbol name)
{
  return attr[index_of_attr_with_name(name)];
}

ClassMethodPair CgenNode::method_at_index(int idx)
{
  assert(idx < int(method.size()));
  return method[idx];
}

ClassMethodPair CgenNode::method_with_name(Symbol name)
{
  return method[index_of_method_with_name(name)];
}


//******************************************************************
//
//   Fill in the following methods to produce code for the
//   appropriate expression.  You may add or remove parameters
//   as you wish, but if you do, remember to change the parameters
//   of the declarations in `cool-tree.h'  Sample code for
//   constant integers, strings, and booleans are provided.
//
//*****************************************************************

//******************************************************************
//
//   Function of Variable Environment
//
//*****************************************************************
void VariableEnvironment::import_class_formal(CgenParameter)
{
  for(int i = 0; i < int(obj_self->attr.size()); i++){
    Symbol attr_name = obj_self->attr[i]->get_name();
    addid_env(attr_name, new Location(SELF, i + 3));
    addid_typ(attr_name, new Symbol(obj_self->attr[i]->get_type()));
  }
  for(int i = 0; i < int(obj_self->method.size()); i++){
    Symbol disp_name = obj_self->method[i].second->get_name();
    Symbol type_name = obj_self->method_dynamic_return_type[i];
    addid_typ(disp_name, new Symbol(type_name));
  }
}

void VariableEnvironment::enterscope()
{
  env->enterscope();
  typ->enterscope();
}

void VariableEnvironment::exitscope()
{
  env->exitscope();
  typ->exitscope();
}

void VariableEnvironment::dump_env()
{
  env->dump();
}

void VariableEnvironment::push_reg_into_stack(Symbol name, char *addr, CgenParameter)
{
  int base = cgen_env->get_stack_base();
  addid_env(name, new Location(SP, base));
  stack_base++;
  emit_push(addr, s);
}

void VariableEnvironment::pop_stack(char *addr, CgenParameter)
{
  stack_base--;
  if(addr != NULL) emit_load(addr, 1, SP, s);
  emit_addiu(SP, SP, 4, s);
}

void VariableEnvironment::alloc_stack(bool output, int x, CgenParameter)
{
  stack_base += x;
  if(output) emit_addiu(SP,SP,-4*x, s);
}

void VariableEnvironment::free_stack(bool output, int x, CgenParameter)
{
  stack_base -= x;
  if(output) emit_addiu(SP, SP, 4*x, s);
}

void VariableEnvironment::addid_env(Symbol key, Location *val)
{
  env->addid(key, val);
}

void VariableEnvironment::addid_typ(Symbol key, Symbol *val)
{
  typ->addid(key, val);
}

Location VariableEnvironment::lookup_env(Symbol name)
{
  Location *ptr = env->lookup(name);
  if(ptr == NULL)
    return Location(NULL,0);
  if(strcmp(reg(*ptr),SP)==0)
    return Location(SP, get_stack_base() - (offset(*ptr)));
  return *ptr;
}

Symbol VariableEnvironment::lookup_typ(Symbol name)
{
  return *(typ->lookup(name));
}

Symbol assign_class::code(CgenParameter)
{
  /* ACC <- v1 */
  s << "# Begin of Assign \n";
  Symbol res = expr->code(CgenParameterInstance);
  /* l1 = E[id] */
  Location l1 = cgen_env->lookup_env(name);
  assert(reg(l1) != NULL);
  /* S' = S[v1/l1] */
  emit_store(ACC, offset(l1), reg(l1), s);
  s << "# End of Assign \n";
  cgen_env->addid_typ(name, new Symbol(res));
  return res;
}


#define string_substr_black_magic \
  /* \
   * Black Magic: the order of arguments is inverse. \
   * Because suggestion in runtime manual is different from the slides. \
   */ \
  if(name == substr){ \
    emit_load(T1, 1, SP, s); \
    emit_load(T2, 2, SP, s); \
    emit_store(T2, 1, SP, s); \
    emit_store(T1, 2, SP, s); \
  }

#define dispatch_abort \
  int jump_abort = cgen_env->assign_label(); \
  emit_bne(ZERO, ACC, jump_abort, s); \
  emit_load_imm(T1, 1, s); \
  emit_load_string(ACC, stringtable.lookup_string(obj_self->filename->get_string()),s); \
  emit_jal("_dispatch_abort", s); \
  emit_label_def(jump_abort, s);

Symbol static_dispatch_class::code(CgenParameter) {
  s << "  # Begin of static dispatch " << name << "\n";
  int parameter_size = int(actual->len());
  int dispatch_stack_base = cgen_env->get_stack_base();
  cgen_env->enterscope();

  cgen_env->alloc_stack(true, parameter_size, CgenParameterInstance);
  for(int i = actual->first(), j = 1; actual->more(i); j++, i = actual->next(i)){
    actual->nth(i)->code(CgenParameterInstance);
    emit_store(ACC, j, SP, s);
  }

  string_substr_black_magic;

  Symbol T_0 = expr->code(CgenParameterInstance);
  dispatch_abort;

  CgenNodeP class_T = cctable->lookup(type_name);
  int f_ind = class_T->index_of_method_with_name(name);
  int f_entry = cgen_env->assign_label();

  emit_load_address(T1, class_T->disp_string, s);
  emit_load(T1, f_ind, T1, s);
  emit_jalr(T1, s);
  s << "  # End of static " << name << "\n";
  cgen_env->exitscope();
  cgen_env->free_stack(false, parameter_size, CgenParameterInstance);
  assert(dispatch_stack_base == cgen_env->get_stack_base());

  if(class_T->method_dynamic_return_type[f_ind] == SELF_TYPE)
    return T_0;
  else
    return class_T->method_dynamic_return_type[f_ind];
}

Symbol dispatch_class::code(CgenParameter)
{
  s << "  # Begin of dispatch " << name << "\n";
  int parameter_size = int(actual->len());
  int dispatch_stack_base = cgen_env->get_stack_base();
  cgen_env->enterscope();
  cgen_env->alloc_stack(true, parameter_size, CgenParameterInstance);
  for(int i = actual->first(), j = 1; actual->more(i); j++, i = actual->next(i)){
    actual->nth(i)->code(CgenParameterInstance);
    emit_store(ACC, j, SP, s);
  }
  string_substr_black_magic;

  Symbol T = expr->code(CgenParameterInstance);

  dispatch_abort;

  CgenNodeP class_T = cctable->lookup(T);
  int f_ind = class_T->index_of_method_with_name(name);
  int f_entry = cgen_env->assign_label();
  assert(f_ind != -1);
  emit_load(T1, 2, ACC, s);
  emit_load(T1, f_ind, T1, s);
  emit_jalr(T1, s);
  s << "  # End of dispatch " << name << "\n";
  cgen_env->exitscope();
  cgen_env->free_stack(false, parameter_size, CgenParameterInstance);
  assert(dispatch_stack_base == cgen_env->get_stack_base());
  //cout << "name: " << name << " T: " << T << " type: " << class_T->method_dynamic_return_type[f_ind] << endl;
  if(class_T->method_dynamic_return_type[f_ind] == SELF_TYPE)
    return T;
  else 
    return class_T->method_dynamic_return_type[f_ind];
}

Symbol cond_class::code(CgenParameter)
{
  // Compute e1 and save to T1
  pred->code(CgenParameterInstance);
  emit_move(T1, ACC, s);
  // Load Bool(true) to T2 
  emit_load_bool(T2, BoolConst(1), s);

  int false_branch = cgen_env->assign_label();
  int true_branch = cgen_env->assign_label();
  int end_if = cgen_env->assign_label();

  emit_beq(T1, T2, true_branch, s);

  emit_label_def(false_branch, s);
  else_exp->code(CgenParameterInstance);
  emit_branch(end_if, s);

  emit_label_def(true_branch, s);
  then_exp->code(CgenParameterInstance);
  emit_label_def(end_if,s);
  return Object;
}

Symbol loop_class::code(CgenParameter)
{
  cgen_env->push_reg_into_stack(No_type, ACC, CgenParameterInstance);
  int loop_pred = cgen_env->assign_label();
  int loop_body = cgen_env->assign_label();
  int loop_end = cgen_env->assign_label();
  emit_label_def(loop_pred, s);
  pred->code(CgenParameterInstance);
  emit_move(T1, ACC, s);
  emit_load_bool(T2, BoolConst(1), s);
  emit_beq(T1, T2, loop_body, s);
  emit_branch(loop_end, s);
  emit_label_def(loop_body, s);
  body->code(CgenParameterInstance);
  emit_branch(loop_pred, s);
  emit_label_def(loop_end,s);
  cgen_env->pop_stack(ACC, CgenParameterInstance);
  return Object;
}

Symbol typcase_class::code(CgenParameter)
{
  cgen_env->enterscope();
  Symbol T_1= expr->code(CgenParameterInstance);

  /* Check case on void */
  emit_move(T1, ACC, s);
  emit_move(ACC, SELF, s);
  int jump_abort = cgen_env->assign_label();
  emit_bne(ZERO, T1, jump_abort, s);
  emit_load_imm(T1, 1, s);
  emit_load_string(ACC, stringtable.lookup_string(obj_self->filename->get_string()),s);
  emit_jal("_case_abort2", s);
  emit_label_def(jump_abort, s);
  emit_move(ACC, T1, s);
  /* ================== */

  std::map< branch_class*, std::vector<CgenNodeP> > enter_branch_with_types;
  for(int i = cases->first(), j = 0; cases->more(i); j++, i = cases->next(i)){
    branch_class *itr = (branch_class*)cases->nth(i);
    enter_branch_with_types[itr] = std::vector<CgenNodeP>();
  }

  /* If the type is self, use BFS to record which branch my posterity will enter */
  std::queue<CgenNodeP> bfs_queue;
  bfs_queue.push(cctable->root());
  while(!bfs_queue.empty()){
    CgenNodeP nd = bfs_queue.front();
    bfs_queue.pop();
    for(List<CgenNode> *l = nd->get_children(); l; l = l->tl())
      bfs_queue.push(l->hd());

    int most_closet_len = 100000000;
    branch_class *res_branch = NULL;
    for(int i = cases->first(), j = 0; cases->more(i); j++, i = cases->next(i)){
      branch_class *itr = (branch_class*)cases->nth(i);
      if(cctable->LCA(nd->get_name(), itr->get_type()) == itr->get_type()){
        int tmp_len = 0;
        for(CgenNodeP nd_itr = cctable->lookup(nd->get_name()); nd_itr != cctable->lookup(itr->get_type()); nd_itr = nd_itr->get_parentnd()){
          tmp_len++;
        }
        if(tmp_len < most_closet_len){
          most_closet_len = tmp_len;
          res_branch = itr;
        }
      }
    }
    enter_branch_with_types[res_branch].push_back(nd);
  }

  if(T_1 == self)
    emit_move(T1, SELF, s);
  else
    emit_move(T1, ACC, s);
  cgen_env->push_reg_into_stack(No_type, T1, CgenParameterInstance);

  std::vector<int> branch_label_start, branch_label_end;
  for(int i = cases->first(); cases->more(i); i = cases->next(i)){
    branch_label_start.push_back(cgen_env->assign_label());
    branch_label_end.push_back(cgen_env->assign_label());
  }

  Symbol ret_type;
  int case_exit = cgen_env->assign_label();
  for(int i = cases->first(), j = 0; cases->more(i); j++, i = cases->next(i)){
    branch_class *itr = (branch_class*)cases->nth(i);

    cgen_env->pop_stack(T1, CgenParameterInstance);
    cgen_env->push_reg_into_stack(No_type, T1, CgenParameterInstance);
    emit_load(T1, 0, T1, s);

    for(int k = 0; k < int(enter_branch_with_types[itr].size()); k++){
      CgenNodeP nd = enter_branch_with_types[itr][k];
      emit_load_address(T2, nd->prot_string, s);
      emit_load(T2, 0, T2, s);
      emit_beq(T1, T2, branch_label_start[j], s);
    }
    emit_branch(branch_label_end[j], s);

    emit_label_def(branch_label_start[j], s);
    cgen_env->push_reg_into_stack(itr->get_name(), ACC, CgenParameterInstance);
    cgen_env->addid_typ(itr->get_name(), new Symbol(itr->get_type()));
    Symbol tmp = itr->expr->code(CgenParameterInstance);
    if(j==0) ret_type = tmp;
    else ret_type = cctable->LCA(ret_type, tmp);

    cgen_env->pop_stack(T3, CgenParameterInstance);
    emit_branch(case_exit, s);
    emit_label_def(branch_label_end[j], s);
  }

  emit_move(ACC, SELF, s);
  emit_jal("_case_abort", s);
  emit_label_def(case_exit, s);

  cgen_env->pop_stack(T3, CgenParameterInstance);
  cgen_env->exitscope();
  return ret_type;
}

Symbol block_class::code(CgenParameter)
{
  Symbol last_type;
  for(int i = body->first(); body->more(i); i = body->next(i))
    last_type = body->nth(i)->code(CgenParameterInstance);
  return last_type;
}

Symbol let_class::code(CgenParameter)
{
  cgen_env->enterscope();
  if(type_decl == Int || type_decl == Bool || type_decl == Str)
    emit_load_address(ACC, cctable->lookup(type_decl)->prot_string, s);
  else
    emit_move(ACC, ZERO, s);
  Symbol init_type = init->code(CgenParameterInstance);
  if(init_type == No_type) init_type = type_decl;
  cgen_env->push_reg_into_stack(identifier, ACC, CgenParameterInstance);
  cgen_env->addid_typ(identifier, new Symbol(init_type));
  Symbol res = body->code(CgenParameterInstance);
  cgen_env->pop_stack(T3, CgenParameterInstance);
  cgen_env->exitscope();
  return res;
}

#define arithmetic(name)   \
  e1->code(CgenParameterInstance); \
  emit_jal(object_copy_method, s); \
  cgen_env->push_reg_into_stack(No_type, ACC, CgenParameterInstance); \
  e2->code(CgenParameterInstance); \
  emit_jal(object_copy_method, s); \
  cgen_env->push_reg_into_stack(No_type, ACC, CgenParameterInstance); \
  cgen_env->pop_stack(T2, CgenParameterInstance); \
  cgen_env->pop_stack(T1, CgenParameterInstance); \
  emit_move(ACC, T1, s); \
  emit_load(T1, 3, T1, s); \
  emit_load(T2, 3, T2, s); \
  emit_##name(T1, T1, T2, s); \
  emit_store(T1, 3, ACC, s); \
  return Int;

Symbol plus_class::code(CgenParameter)
{
  arithmetic(add);
}

Symbol sub_class::code(CgenParameter)
{
  arithmetic(sub);
}

Symbol mul_class::code(CgenParameter)
{
  arithmetic(mul);
}

Symbol divide_class::code(CgenParameter)
{
  arithmetic(div);
}

Symbol neg_class::code(CgenParameter)
{
  e1->code(CgenParameterInstance);
  emit_jal(object_copy_method, s);
  emit_load(T1, 3, ACC, s);
  emit_neg(T1, T1, s);
  emit_store(T1, 3, ACC, s);
  return Int;
}

#define compare_e1_e2_head \
  int false_branch = cgen_env->assign_label(); \
  int true_branch = cgen_env->assign_label(); \
  int end_if = cgen_env->assign_label(); \
  Symbol Type1 = e1->code(CgenParameterInstance); \
  cgen_env->push_reg_into_stack(No_type, ACC, CgenParameterInstance); \
  e2->code(CgenParameterInstance); \
  cgen_env->push_reg_into_stack(No_type, ACC, CgenParameterInstance); \
  cgen_env->pop_stack(T2, CgenParameterInstance); \
  cgen_env->pop_stack(T1, CgenParameterInstance); \
  emit_load_bool(ACC, BoolConst(1), s); \
  emit_load_bool(A1, BoolConst(0), s);

#define compare_e1_e2_mid \
  if(Type1 == Bool || Type1 == Int || Type1 == Str){ \
    emit_load(T1, 3, T1, s); \
    emit_load(T2, 3, T2, s); \
  }

#define compare_e1_e2_tail(name) \
  emit_##name(T1, T2, true_branch, s); \
  emit_label_def(false_branch, s); \
  emit_load_bool(ACC, BoolConst(0), s); \
  emit_branch(end_if, s); \
  emit_label_def(true_branch, s); \
  emit_load_bool(ACC, BoolConst(1), s); \
  emit_label_def(end_if,s);

Symbol lt_class::code(CgenParameter)
{
  compare_e1_e2_head;
  compare_e1_e2_mid;
  compare_e1_e2_tail(blt);
  return Bool;
}

Symbol eq_class::code(CgenParameter)
{
  compare_e1_e2_head;
  emit_beq(T1, T2, end_if, s);
  emit_jal("equality_test", s);
  emit_load(T3, 3, ACC, s);
  emit_beqz(T3, false_branch, s);
  emit_load_bool(ACC, BoolConst(1), s);
  emit_branch(end_if, s);
  emit_label_def(false_branch, s);
  emit_load_bool(ACC, BoolConst(0), s);
  emit_label_def(end_if,s);
  return Bool;
}

Symbol leq_class::code(CgenParameter)
{
  compare_e1_e2_head;
  compare_e1_e2_mid;
  compare_e1_e2_tail(bleq);
  return Bool;
}

Symbol comp_class::code(CgenParameter)
{
  e1->code(CgenParameterInstance);
  emit_load(T1, 3, ACC, s);
  int false_branch = cgen_env->assign_label();
  int true_branch = cgen_env->assign_label();
  int end_if = cgen_env->assign_label();

  emit_beqz(T1, false_branch, s);

  emit_label_def(true_branch, s);
  emit_load_bool(ACC, BoolConst(0), s);
  emit_branch(end_if, s);

  emit_label_def(false_branch, s);
  emit_load_bool(ACC, BoolConst(1), s);
  emit_label_def(end_if,s);
  return Bool;
}

Symbol int_const_class::code(CgenParameter)
{ // Need to be sure we have an IntEntry *, not an arbitrary Symbol
  emit_load_int(ACC,inttable.lookup_string(token->get_string()),s);
  emit_jal(object_copy_method, s);
  return Int;
}

Symbol string_const_class::code(CgenParameter)
{
  emit_load_string(ACC,stringtable.lookup_string(token->get_string()),s);
  return Str;
}

Symbol bool_const_class::code(CgenParameter)
{
  emit_load_bool(ACC, BoolConst(val), s);
  return Bool;
}

Symbol new__class::code(CgenParameter)
{
  Symbol required_type = type_name;
  if(required_type != SELF_TYPE){
    emit_load_address(ACC, cctable->lookup(required_type)->prot_string, s);
    emit_jal(object_copy_method, s);
    emit_jal(cctable->lookup(required_type)->init_string, s);
  }else{
    emit_load_address(T1, CLASSOBJTAB, s);
    emit_load(T2, 0, SELF, s);
    emit_sll(T2, T2, 3, s);
    emit_add(T1, T1, T2, s);
    cgen_env->push_reg_into_stack(No_type, T1, CgenParameterInstance);
    emit_load(ACC, 0, T1, s);
    emit_jal(object_copy_method, s);
    cgen_env->pop_stack(T3, CgenParameterInstance);
    emit_load(T1, 1, T3, s);
    emit_jalr(T1, s);
  }

  return required_type;
}

Symbol isvoid_class::code(CgenParameter)
{
  e1->code(CgenParameterInstance);

  int false_branch = cgen_env->assign_label();
  int true_branch = cgen_env->assign_label();
  int end_if = cgen_env->assign_label();

  emit_beqz(ACC, true_branch, s);

  emit_label_def(false_branch, s);
  emit_load_bool(ACC, BoolConst(0), s);
  emit_branch(end_if, s);

  emit_label_def(true_branch, s);
  emit_load_bool(ACC, BoolConst(1), s);
  emit_label_def(end_if,s);
  return Bool;
}

Symbol no_expr_class::code(CgenParameter)
{
  return No_type;
}

Symbol object_class::code(CgenParameter)
{
  s << "  # Try to find " << name << "\n";
  if(name == self){
    emit_move(ACC, SELF, s);
    return obj_self->get_name();
  }else{
    Location loc = cgen_env->lookup_env(name);
    if(reg(loc) == NULL){
      cerr << "========= I can't find: " << name << " in " << obj_self->get_name() << endl;
      assert(reg(loc) != NULL);
      return No_type;
    }
    s << "# in the " << offset(loc) << " of " << reg(loc) << "\n";

    emit_load(ACC, offset(loc), reg(loc), s);
    return cgen_env->lookup_typ(name);
  }
}

