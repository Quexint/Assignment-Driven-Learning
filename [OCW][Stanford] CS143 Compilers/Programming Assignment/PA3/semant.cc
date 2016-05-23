

#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include "semant.h"
#include "utilities.h"

extern int semant_debug;
extern char *curr_filename;

//////////////////////////////////////////////////////////////////////
//
// Symbols
//
// For convenience, a large number of symbols are predefined here.
// These symbols include the primitive type and method names, as well
// as fixed names used by the runtime system.
//
//////////////////////////////////////////////////////////////////////
static Symbol
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
  val,
  dfs;
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
  // Customized Definition
  dfs         = idtable.add_string("dfs");
}

/* ======================== Useful Routine ======================== */
#define SemantEnvironment             \
  class__class *c = (class__class*)myclass; \
  TypeEnvironmentEntry *infosymtable = (symtable->lookup(c->get_name()));  \
  TypeEnvironmentEntry *localsymtable = (symtable->lookup(dfs));   \
  MethodEnvironmentEntry *localfunctable = (functable->lookup(c->get_name()));

std::pair<Symbol, Symbol> make_pair(Symbol a, Symbol b){ return std::pair<Symbol, Symbol>(a, b); }
Symbol class__class::get_name() { return name; }
Symbol class__class::get_parent() { return parent; }
bool isBasicClass(Symbol sym){ return (sym == SELF_TYPE || sym == Object || sym == IO || sym == Int || sym == Str || sym == Bool); }
bool isIllegalParent(Symbol par){ return (par == SELF_TYPE || par == Int || par == Bool || par == Str); }

/* ======================== TypeGraph: Inheritance Graph ======================== */
void TypeGraph::AddType(Symbol sym){ par_table->addid(sym, new Symbol(No_type)); }

void TypeGraph::AddEdge(Symbol par, Symbol chd, class__class *c){
  if(par_table->lookup(par) == NULL) AddType(par);
  if(par_table->lookup(chd) == NULL) AddType(chd);
  par_table->addid(chd, new Symbol(par));
}

Symbol TypeGraph::LeastCommonAncestor(Symbol typeA, Symbol typeB){
  std::vector< Symbol > arrA, arrB;
  arrA.clear(); arrB.clear();

  for(Symbol itr = typeA; itr != No_class; itr = *(par_table->lookup(itr)))
    arrA.push_back(itr);

  for(Symbol itr = typeB; itr != No_class; itr = *(par_table->lookup(itr)))
    arrB.push_back(itr);

  Symbol answer;
  for(; arrA.size() > 0 && arrB.size() > 0 && arrA.back() == arrB.back(); arrA.pop_back(), arrB.pop_back())
    answer = arrA.back();

  return answer;
}

bool TypeGraph::isAncestorOfB(Symbol typeA, Symbol typeB){ return LeastCommonAncestor(typeA, typeB) == typeA; }

TypeGraph::TypeGraph(Classes classes){
  par_table = new TypeEnvironmentEntry();
  par_table->enterscope();

  for(int i = classes->first(); classes->more(i); i = classes->next(i)){
    class__class *c = (class__class*)classes->nth(i);
    Symbol chd = c->get_name();
    Symbol par = c->get_parent();
    AddEdge(par, chd, c);
  }
}

ClassTable::ClassTable(Classes classes) : semant_errors(0) , error_stream(cerr) {

  bool isMainExist = false;
  TypeEnvironmentEntry *tmp_par_table = new TypeEnvironmentEntry();
  tmp_par_table->enterscope();

  filename = classes->nth(classes->first())->get_filename();

  tmp_par_table->addid(Object, new Symbol(No_class));
  tmp_par_table->addid(IO, new Symbol(Object));
  tmp_par_table->addid(Int, new Symbol(Object));
  tmp_par_table->addid(Bool, new Symbol(Object));
  tmp_par_table->addid(Str, new Symbol(Object));
  tmp_par_table->addid(SELF_TYPE, new Symbol(Object));

  /* Stage 1 Checking */
  Classes stage1_classes = nil_Classes();
  for(int i = classes->first(); classes->more(i); i = classes->next(i)){
    class__class *c = (class__class*)classes->nth(i);
    Symbol chd = c->get_name();
    Symbol par = c->get_parent();
    bool isClassGood = true;

    /* Is main redefined ? */
    if(chd == Main && isMainExist == true)
      semant_error(c) << "Redefinition of basic class Main.\n";

    /* Does main exist? */
    if(chd == Main) isMainExist = true;

    /* Does it inherits the basic objects? */
    if(isIllegalParent(par))
      isClassGood = false, semant_error(c) << "Class " << chd << " cannot inherit class " << par << ".\n";

    /* Does it redefined some class? */
    if(tmp_par_table->lookup(chd) != NULL){
      isClassGood = false;
      if(isBasicClass(chd))
        semant_error(c) << "Redefinition of basic class " << chd << ".\n";
      else
        semant_error(c) << "Class " << chd << " was previously defined.\n";
    }

    if(isClassGood){
      tmp_par_table->addid(chd, new Symbol(par));
      stage1_classes = append_Classes(stage1_classes, single_Classes(c));
    }
  }

  if(isMainExist == false)
    semant_error() << "Class Main is not defined.\n";

  good_classes = nil_Classes();
  for(int i = stage1_classes->first(); stage1_classes->more(i); i = stage1_classes->next(i)){
    bool isClassGood = true;
    class__class *c = (class__class*)stage1_classes->nth(i);
    Symbol chd = c->get_name();
    Symbol par = c->get_parent();

    /* Does the parent class exist? */
    if(tmp_par_table->lookup(par) == NULL)
      isClassGood = false, semant_error(c) << "Class " << chd << " inherits from an undefined class " << par << ".\n";

    /* Does there exist an inheritance loop? */
    for(Symbol itr = par; isClassGood && tmp_par_table->lookup(itr) != NULL; itr = *(tmp_par_table->lookup(itr)))
      if(itr == chd){
        semant_error(c) << "Class " << chd << " inherits Circuitly.\n";
        isClassGood = false;
        break;
      }

    if(isClassGood)
      good_classes = append_Classes(good_classes, single_Classes(c));
  }

  install_basic_classes();
  delete tmp_par_table;
}

void ClassTable::install_basic_classes() {

  // The tree package uses these globals to annotate the classes built below.
  // curr_lineno  = 0;
  //Symbol filename = stringtable.add_string("<basic class>");

  // The following demonstrates how to create dummy parse trees to
  // refer to basic Cool classes.  There's no need for method
  // bodies -- these are already built into the runtime system.

  // IMPORTANT: The results of the following expressions are
  // stored in local variables.  You will want to do something
  // with those variables at the end of this method to make this
  // code meaningful.

  //
  // The Object class has no parent class. Its methods are
  //        abort() : Object    aborts the program
  //        type_name() : Str   returns a string representation of class name
  //        copy() : SELF_TYPE  returns a copy of the object
  //
  // There is no need for method bodies in the basic classes---these
  // are already built in to the runtime system.

  Class_ Object_class =
    class_(Object,
        No_class,
        append_Features(
          append_Features(
            single_Features(method(cool_abort, nil_Formals(), Object, no_expr())),
            single_Features(method(type_name, nil_Formals(), Str, no_expr()))),
          single_Features(method(copy, nil_Formals(), SELF_TYPE, no_expr()))),
        filename);

  //
  // The IO class inherits from Object. Its methods are
  //        out_string(Str) : SELF_TYPE       writes a string to the output
  //        out_int(Int) : SELF_TYPE            "    an int    "  "     "
  //        in_string() : Str                 reads a string from the input
  //        in_int() : Int                      "   an int     "  "     "
  //
  Class_ IO_class =
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
        filename);

  //
  // The Int class has no methods and only a single attribute, the
  // "val" for the integer.
  //
  Class_ Int_class =
    class_(Int,
        Object,
        single_Features(attr(val, prim_slot, no_expr())),
        filename);

  //
  // Bool also has only the "val" slot.
  //
  Class_ Bool_class =
    class_(Bool, Object, single_Features(attr(val, prim_slot, no_expr())),filename);

  //
  // The class Str has a number of slots and operations:
  //       val                                  the length of the string
  //       str_field                            the string itself
  //       length() : Int                       returns length of the string
  //       concat(arg: Str) : Str               performs string concatenation
  //       substr(arg: Int, arg2: Int): Str     substring selection
  //
  Class_ Str_class =
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
        filename);

  good_classes = append_Classes(good_classes, single_Classes(Object_class));
  good_classes = append_Classes(good_classes, single_Classes(IO_class));
  good_classes = append_Classes(good_classes, single_Classes(Int_class));
  good_classes = append_Classes(good_classes, single_Classes(Str_class));
  good_classes = append_Classes(good_classes, single_Classes(Bool_class));
}

////////////////////////////////////////////////////////////////////
//
// semant_error is an overloaded function for reporting errors
// during semantic analysis.  There are three versions:
//
//    ostream& ClassTable::semant_error()
//
//    ostream& ClassTable::semant_error(Class_ c)
//       print line number and filename for `c'
//
//    ostream& ClassTable::semant_error(Symbol filename, tree_node *t)
//       print a line number and filename
//
///////////////////////////////////////////////////////////////////

ostream& ClassTable::semant_error(Class_ c)
{
  return semant_error(c->get_filename(),c);
}

ostream& ClassTable::semant_error(Symbol filename, tree_node *t)
{
  error_stream << filename << ":" << t->get_line_number() << ": ";
  return semant_error();
}

ostream& ClassTable::semant_error()
{
  semant_errors++;
  return error_stream;
}

ostream& inline_semant_error(ostream &stream, int &errors, Class_ myclass){
  errors++;
  stream << myclass->get_filename() << ":" << myclass->get_line_number() << ": ";
  return stream;
}


/*   This is the entry point to the semantic checker.

     Your checker should do the following two things:

     1) Check that the program is semantically correct
     2) Decorate the abstract syntax tree with type information
     by setting the `type' field in each Expression node.
     (see `tree.h')

     You are free to first do 1), make sure you catch all semantic
     errors. Part 2) can be done in a second stage, when you want
     to build mycoolc.
     */
void program_class::semant()
{
  initialize_constants();

  /* ClassTable constructor may do some semantic analysis */
  ClassTable *classtable = new ClassTable(classes);
  TypeGraph *typegraph = new TypeGraph(classtable->good_classes);
  TypeEnvironment *symtable = new TypeEnvironment();
  MethodEnvironment *functable = new MethodEnvironment();

  symtable->enterscope();
  functable->enterscope();
  symtable->addid(dfs, new TypeEnvironmentEntry());

  /* Gather all needed information from filtered classes */
  classes = classtable->good_classes->copy_list();
  traverse(cerr, classtable->ref_errors(), symtable, functable, NULL, typegraph, 0);
  traverse(cerr, classtable->ref_errors(), symtable, functable, NULL, typegraph, 1);

  /* Removing Basic Types */
  Classes res_classes = nil_Classes();
  for(int i = classes->first(); classes->more(i); i = classes->next(i)){
    class__class *c = (class__class*)classes->nth(i);
    if(!isBasicClass(c->get_name()))
      res_classes = append_Classes(res_classes, single_Classes(c));
  }
  classes = res_classes;

  if (classtable->errors()) {
    cerr << "Compilation halted due to static semantic errors." << endl;
    exit(1);
  }
}

Symbol program_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  for(int i = classes->first(); classes->more(i); i = classes->next(i)){
    class__class *c = (class__class*)classes->nth(i);
    Symbol chd = (c->get_name());
    Symbol par = (c->get_parent());

    if(symtable->lookup(c->get_name()) == NULL) symtable->addid(c->get_name(), new TypeEnvironmentEntry());
    if(functable->lookup(c->get_name()) == NULL) functable->addid(c->get_name(), new MethodEnvironmentEntry());
    symtable->lookup(c->get_name())->enterscope();
    functable->lookup(c->get_name())->enterscope();
    symtable->lookup(dfs)->enterscope();

    if(isFinalPass == 0 || isBasicClass(chd)==false)
      classes->nth(i)->traverse(stream, errors, symtable, functable, classes->nth(i), typegraph, isFinalPass);

    symtable->lookup(dfs)->exitscope();
  }
  return No_type;
}

Symbol class__class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  SemantEnvironment;

  for(int i = features->first(); features->more(i); i = features->next(i))
    features->nth(i)->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  return c->get_name();
}

Symbol method_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  SemantEnvironment;
  std::vector<std::pair<Symbol,Symbol> > paramArr;
  Symbol symItr;

  /* Save the types and parameter's name */
  localfunctable->addid(name, new std::vector<std::pair<Symbol, Symbol> >());
  localsymtable->enterscope();
  for(int i = formals->first(); formals->more(i); i = formals->next(i)){
    formal_class *fi = (formal_class*)formals->nth(i);
    Symbol Ti = fi->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
    localfunctable->lookup(name)->push_back(make_pair(Ti, fi->get_name()));
  }
  localfunctable->lookup(name)->push_back(make_pair(return_type, No_type));

  /* Is the method overriding the parent method? */
  for(symItr = *(typegraph->par_table->lookup(c->get_name())); symItr!=No_class; symItr = *(typegraph->par_table->lookup(symItr)))
    if(functable->lookup(symItr) != NULL && functable->lookup(symItr)->lookup(name) != NULL)
      paramArr = *(functable->lookup(symItr)->lookup(name));

  if(paramArr.size() != 0 && paramArr.size() != localfunctable->lookup(name)->size())
    isFinalPass && inline_semant_error(stream, errors, myclass) << "Wrong Parameter numbers.\n";
  else{
    for(int i=0; i < int(paramArr.size()); i++)
      if((paramArr[i]).first != (*localfunctable->lookup(name))[i].first)
        isFinalPass && inline_semant_error(stream, errors, myclass) << "In redefined method " << name << ", parameter type " << (*localfunctable->lookup(name))[i].first << " is different from original type " << paramArr[i].first << endl;
  }

  Symbol e0 = expr->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  if(!(isBasicClass(c->get_name())) && isFinalPass){
    if(return_type == SELF_TYPE && e0 != SELF_TYPE)
      isFinalPass && inline_semant_error(stream, errors, myclass) << "Inferred return type " << e0 << " of method " << name << " does not conform to declared return type " << return_type << ".\n";
    else if(return_type != SELF_TYPE && typegraph->par_table->lookup(return_type) == NULL)
      isFinalPass && inline_semant_error(stream, errors, myclass) << "Undefined return type " << return_type << " in method " << name << ".\n";
    else if(e0 != return_type){
      Symbol T0 = e0;
      Symbol R0 = return_type;
      if(T0 == SELF_TYPE) T0 = c->get_name();
      if(R0 == SELF_TYPE) R0 = c->get_name();
      if(!(typegraph->isAncestorOfB(R0, T0)))
        isFinalPass && inline_semant_error(stream, errors, myclass) << "Wrong ret types.\n";
    }
  }

  localsymtable->exitscope();
  return return_type;
}

Symbol attr_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  SemantEnvironment;
  Symbol x = name;
  Symbol T0 = type_decl;
  Symbol T1 = init->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  if(T0 == SELF_TYPE) T0 = c->get_name();
  if(T1 == SELF_TYPE) T1 = c->get_name();

  if(x == self){
    isFinalPass && inline_semant_error(stream, errors, myclass) << "'" << name << "' cannot be the name of an attribute.\n";
    return type_decl;
  }

  for(Symbol itr = *(typegraph->par_table->lookup(c->get_name())); itr != No_class; itr = *(typegraph->par_table->lookup(itr)))
    if(symtable->lookup(itr) != NULL && symtable->lookup(itr)->lookup(x) != NULL){
      isFinalPass && inline_semant_error(stream, errors, myclass) << "Attribute " << x << " is an attribute of an inherited class.\n";
      break;
    }

  if(T1 != No_type && !(typegraph->isAncestorOfB(T0, T1)))
    isFinalPass && inline_semant_error(stream, errors, myclass) << "Type " << T1 << " of assigned expression does not conform to declared type " << T0 << " of identifier " << x << ".\n"; 

  localsymtable->addid(name, new Symbol(type_decl));
  infosymtable->addid(name, new Symbol(type_decl));
  return type_decl;
}

Symbol formal_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  SemantEnvironment;

  if(localsymtable->probe(name) != NULL)
    isFinalPass && inline_semant_error(stream, errors, myclass) << "Formal parameter " << name << " is multiply defined.\n";
  if(name == self)
    isFinalPass && inline_semant_error(stream, errors, myclass) << "'self' cannot be the name of a formal parameter.\n";
  if(type_decl == SELF_TYPE)
    isFinalPass && inline_semant_error(stream, errors, myclass) << "Formal parameter x cannot have type SELF_TYPE.\n";

  localsymtable->addid(name, new Symbol(type_decl));
  Symbol T1 = type_decl;
  return type_decl;
}

Symbol branch_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  SemantEnvironment;
  localsymtable->addid(name, new Symbol(type_decl));

  Symbol T1 = expr->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  if(T1 == SELF_TYPE) T1 = (c->get_name());
  return T1;
}

Symbol assign_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  SemantEnvironment;
  Symbol x = name;
  Symbol T1 = expr->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  Symbol T0 = Object;

  if(name == self){
    isFinalPass && inline_semant_error(stream, errors, myclass) << "Cannot assign to 'self'.\n";
    return type = Object;
  }

  if(localsymtable->lookup(x) != NULL)
    T0 = *(localsymtable->lookup(x));
  else {
    Symbol itr = No_class;
    for(itr = c->get_name(); itr != No_class; itr = *(typegraph->par_table->lookup(itr)))
      if(symtable->lookup(itr) != NULL && symtable->lookup(itr)->lookup(x) != NULL){
        T0 = *(symtable->lookup(itr)->lookup(x));
        break;
      }

    if(itr == No_class){
      isFinalPass && inline_semant_error(stream, errors, myclass) << "undefined id: " << x << "\n";
      return type = Object;
    }
  }

  if(T1 == SELF_TYPE) T1 = c->get_name();
  if(T0 == SELF_TYPE) T0 = c->get_name();

  if(T1 != No_type && !(typegraph->isAncestorOfB(T0, T1)))
    isFinalPass && inline_semant_error(stream, errors, myclass) << "Type " << T1 << " of assigned expression does not conform to declared type " << T0 << " of identifier " << x << ".\n"; 
  return type = T0;
}

Symbol static_dispatch_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  SemantEnvironment;
  Symbol T = type_name;
  Symbol e0 = expr->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  Symbol T0 = e0;
  if(T0 == SELF_TYPE) T0 = c->get_name();
  if(T == SELF_TYPE) T = c->get_name();

  if(!(typegraph->isAncestorOfB(T, T0)))
    isFinalPass && inline_semant_error(stream, errors, myclass) << "You can't upgrade the type " << T0 << " to the type" << T << ".\n";

  for(int i = actual->first(); actual->more(i); i = actual->next(i))
    actual->nth(i)->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);

  Symbol T_ = T;
  Symbol symItr;
  for(symItr = T_; symItr != No_class && (functable->lookup(symItr) == NULL || functable->lookup(symItr)->lookup(name) == NULL); symItr = *(typegraph->par_table->lookup(symItr)));
  if(symItr != No_class) T_ = symItr;

  if(functable->lookup(T_) != NULL && functable->lookup(T_)->lookup(name) != NULL){
    if(functable->lookup(T_)->lookup(name)->back().first == SELF_TYPE)
      return type = e0;
    return type = (functable->lookup(T_)->lookup(name)->back().first);
  }
  return Object;
}

Symbol dispatch_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  SemantEnvironment;
  Symbol e0 = expr->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  Symbol T0 = e0;
  if(T0 == SELF_TYPE) T0 = c->get_name();
  Symbol symItr;

  /* Find the method from the inharitance graph */
  for(symItr = T0; symItr != No_class && (functable->lookup(symItr) == NULL || functable->lookup(symItr)->lookup(name) == NULL); symItr = *(typegraph->par_table->lookup(symItr)));
  if(symItr == No_class) symItr = T0;
  /* The method doesn't exist. Don't care in the first time. */
  if(functable->lookup(symItr) == NULL || functable->lookup(symItr)->lookup(name) == NULL){
    for(int i = actual->first(); actual->more(i); i = actual->next(i))
      actual->nth(i)->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
    isFinalPass && inline_semant_error(stream, errors, myclass) << "Dispatch to undefined method " << name << "." << endl;
    return type = Object;
  }

  std::vector<std::pair<Symbol, Symbol> > &f = *(functable->lookup(symItr)->lookup(name));
  int itr = 0;

  for(int i = actual->first(); actual->more(i); i = actual->next(i), itr++){
    Symbol Ti = actual->nth(i)->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
    if(Ti == SELF_TYPE) Ti = (c->get_name());
    if(itr < int(f.size()) - 1){
      Symbol Tii = f[itr].first;
      if(Tii == SELF_TYPE) Tii = (c->get_name());
      if(!(typegraph->isAncestorOfB(Tii, Ti)))
        isFinalPass && inline_semant_error(stream, errors, myclass) << "In call of method " << name << ", type " << Ti << " of parameter " << f[itr].second << " does not conform to declared type " << Tii << ".\n";
    }
  }
  if(itr != int(f.size()) - 1)
    isFinalPass && inline_semant_error(stream, errors, myclass) << "Method needs more parameters.\n";

  if(functable->lookup(symItr)->lookup(name)->size() > 0){
    if(functable->lookup(symItr)->lookup(name)->back().first == SELF_TYPE)
      return type = e0;
    return type = (functable->lookup(symItr)->lookup(name)->back().first);
  }
  return type = Object;
}

Symbol cond_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  SemantEnvironment;
  Symbol e0 = pred->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  Symbol e1 = then_exp->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  Symbol e2 = else_exp->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);

  if(e0 != Bool) isFinalPass && inline_semant_error(stream, errors, myclass) << "[IF-THEN-ELSE] e0 got non Bool type.\n";
  if(e1 == No_type){
    isFinalPass && inline_semant_error(stream, errors, myclass) << "[IF-THEN-ELSE] e1 got no type.\n";
    return No_type;
  }
  if(e2 == No_type){
    isFinalPass && inline_semant_error(stream, errors, myclass) << "[IF-THEN-ELSE] e2 got no type.\n";
    return No_type;
  }

  if(e1 == SELF_TYPE) e1 = c->get_name();
  if(e2 == SELF_TYPE) e2 = c->get_name();
  return type = typegraph->LeastCommonAncestor(e1, e2);
}

Symbol loop_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  Symbol e1 = pred->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  Symbol e2 = body->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  if(e1 != Bool) isFinalPass && inline_semant_error(stream, errors, myclass) << "Loop condition does not have type Bool.\n";
  return type = Object;
}

Symbol typcase_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  SemantEnvironment;
  std::vector<Symbol> ret_case;
  Symbol ret_type;
  ret_case.clear();

  localsymtable->enterscope();
  expr->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  for(int i = cases->first(); cases->more(i); i = cases->next(i)){
    localsymtable->enterscope();

    branch_class *ci = (branch_class*)cases->nth(i);
    Symbol Ti = cases->nth(i)->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
    if(Ti == SELF_TYPE) Ti = c->get_name();

    ret_case.push_back(ci->get_type_decl());

    if(i == cases->first()) ret_type = Ti;
    else ret_type = typegraph->LeastCommonAncestor(ret_type, Ti);

    localsymtable->exitscope();
  }
  localsymtable->exitscope();

  for(int i = 0; i < int(ret_case.size()); i++)
    for(int j = i+1; j < int(ret_case.size()); j++)
      if(ret_case[i] == ret_case[j])
        isFinalPass && inline_semant_error(stream, errors, myclass) << "Duplicate branch " << ret_case[i] << " in case statement.\n";
  return type = ret_type;
}

Symbol block_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  SemantEnvironment;
  Symbol last_ret = No_type;

  localsymtable->enterscope();
  for(int i = body->first(); body->more(i); i = body->next(i)){
    last_ret = body->nth(i)->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  }
  localsymtable->exitscope();

  return type = last_ret;
}

Symbol let_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  SemantEnvironment;

  Symbol x = identifier;
  Symbol T = type_decl;
  localsymtable->enterscope();
  localsymtable->addid(x, new Symbol(T));

  Symbol e0 = init->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  Symbol T0 = e0;
  Symbol T1 = body->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  if(e0 == SELF_TYPE) T0 = c->get_name();
  if(type_decl == SELF_TYPE) T = c->get_name();

  if(x == self)
    isFinalPass && inline_semant_error(stream, errors, myclass) << "'self' cannot be bound in a 'let' expression.\n";
  else {
    if(T0 != No_type && !(typegraph->isAncestorOfB(T, T0)))
      isFinalPass && inline_semant_error(stream, errors, myclass) << "Wrong let assign\n";
  }

  localsymtable->exitscope();
  return type = T1;
}

Symbol plus_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  Symbol T1 = e1->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  Symbol T2 = e2->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  if(T1 != Int || T2 != Int){
    isFinalPass && inline_semant_error(stream, errors, myclass) << "non-Int arguments: " << T1 << " + " << T2 <<"\n";
    return type = Object;
  }

  return type = Int;
}

Symbol sub_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  Symbol T1 = e1->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  Symbol T2 = e2->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  if(T1 != Int || T2 != Int){
    isFinalPass && inline_semant_error(stream, errors, myclass) << "non-Int arguments: " << T1 << " - " << T2 <<"\n";
    return type = Object;
  }

  return type = Int;
}

Symbol mul_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  Symbol T1 = e1->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  Symbol T2 = e2->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  if(T1 != Int || T2 != Int){
    isFinalPass && inline_semant_error(stream, errors, myclass) << "non-Int arguments: " << T1 << " * " << T2 <<"\n";
    return type = Object;
  }

  return type = Int;
}

Symbol divide_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  Symbol T1 = e1->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  Symbol T2 = e2->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  if(T1 != Int || T2 != Int){
    isFinalPass && inline_semant_error(stream, errors, myclass) << "non-Int arguments: " << T1 << " / " << T2 <<"\n";
    return type = Object;
  }

  return type = Int;
}

Symbol neg_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  Symbol T1 = e1->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  if(T1 != Int){
    isFinalPass && inline_semant_error(stream, errors, myclass) << "neg wrong.\n";
    return type = T1;
  }

  return type = Int;
}

Symbol lt_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  Symbol T1 = e1->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  Symbol T2 = e2->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  if(T1 != Int || T2 != Int){
    isFinalPass && inline_semant_error(stream, errors, myclass) << "lt wrong.\n";
    return type = Object;
  }

  return type = Bool;
}


Symbol eq_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  Symbol T1 = e1->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  Symbol T2 = e2->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  if((T1 != T2 ) && (T1 == Int || T2 == Int || T1 == Bool || T2 == Bool || T1 == Str || T2 == Str)){
    isFinalPass && inline_semant_error(stream, errors, myclass) << "Illegal comparison with a basic type.\n";
    return type = Object;
  }

  return type = Bool;
}

Symbol leq_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  Symbol T1 = e1->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  Symbol T2 = e2->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  if(T1 != Int || T2 != Int) {
    isFinalPass && inline_semant_error(stream, errors, myclass) << "leq Wrong\n";
    return type = Object;
  }

  return type = Bool;
}

Symbol comp_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  Symbol T1 = e1->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  return type = T1;
}

Symbol int_const_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  return type = Int;
}

Symbol bool_const_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  return type = Bool;
}

Symbol string_const_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  return type = Str;
}

Symbol new__class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  if(type_name != SELF_TYPE && typegraph->par_table->lookup(type_name) == NULL)
    isFinalPass && inline_semant_error(stream, errors, myclass) << "'new' used with undefined class " << type_name << ".\n";
  return type = type_name;
}

Symbol isvoid_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  Symbol T1 = e1->traverse(stream, errors, symtable, functable, myclass, typegraph, isFinalPass);
  return type = Bool;
}

Symbol no_expr_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  return No_type;
}

Symbol object_class::traverse(ostream& stream, int &errors, TypeEnvironment *symtable, MethodEnvironment *functable, Class_ myclass, TypeGraph *typegraph, int isFinalPass)
{
  SemantEnvironment;

  if(name == self)
    return type = SELF_TYPE;
  if(localsymtable->lookup(name) != NULL)
    return type = *(localsymtable->lookup(name));

  for(Symbol itr = c->get_name(); itr != No_class; itr = *(typegraph->par_table->lookup(itr))){
    if(symtable->lookup(itr) != NULL && symtable->lookup(itr)->lookup(name) != NULL)
      return type = *(symtable->lookup(itr)->lookup(name));
    if(functable->lookup(itr) != NULL && functable->lookup(itr)->lookup(name) != NULL)
      return type = (functable->lookup(itr)->lookup(name)->back().first);
  }

  if(typegraph->par_table->lookup(name) != NULL)
    return type = name;

  isFinalPass && inline_semant_error(stream, errors, myclass) << "Undefined ID\n";
  return type = Object;
}
