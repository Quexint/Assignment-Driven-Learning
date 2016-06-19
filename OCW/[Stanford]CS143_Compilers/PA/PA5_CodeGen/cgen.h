#include <assert.h>
#include <stdio.h>
#include "emit.h"
#include "cool-tree.h"


enum Basicness     {Basic, NotBasic};
#define TRUE 1
#define FALSE 0

class CgenClassTable;
typedef CgenClassTable *CgenClassTableP;

class CgenNode;
typedef CgenNode *CgenNodeP;

class CgenClassTable : public SymbolTable<Symbol,CgenNode>
{
  private:
    List<CgenNode> *nds;
    ostream& str;
    int stringclasstag;
    int intclasstag;
    int boolclasstag;
    int objectclasstag;
    int ioclasstag;

    int tag_count;
    VariableEnvironment *cgen_env;

    void code_global_data();
    void code_global_text();
    void code_bools(int);
    void code_select_gc();
    void code_constants();

    void code_nameTab();
    void code_objTab();
    void code_layout();
    void code_dispTab();
    void code_protTab();
    void code_objInit();
    void code_classMethod();

    // The following creates an inheritance graph from
    // a list of classes.  The graph is implemented as
    // a tree of `CgenNode', and class names are placed
    // in the base class symbol table.

    void install_basic_classes();
    void install_class(CgenNodeP nd);
    void install_classes(Classes cs);
    void build_inheritance_tree();
    void set_relations(CgenNodeP nd);
  public:
    int assign_tag(){ ++tag_count; return tag_count; }
    CgenClassTable(Classes, ostream& str);
    Symbol code();
    CgenNodeP root();
    CgenNodeP class_with_tag(int x);
    Symbol LCA(Symbol T_1, Symbol T_2);
};

class CgenNode : public class__class
{
  private: 
    CgenNodeP parentnd;                       // Parent of class
    List<CgenNode> *children;                 // Children of class
    Basicness basic_status;                   // `Basic' if class is basic
                                              // `NotBasic' otherwise
    int object_tag, object_size;

  public:
    char *init_string, *prot_string, *disp_string;

    CgenNode(Class_ c,
        Basicness bstatus,
        CgenClassTableP class_table);

    void add_child(CgenNodeP child);
    List<CgenNode> *get_children() { return children; }
    void set_parentnd(CgenNodeP p);
    CgenNodeP get_parentnd() { return parentnd; }
    int basic() { return (basic_status == Basic); }

    AttrVector attr;
    MethodVector method;
    SymbolVector method_dynamic_return_type;

    int index_of_attr_with_name(Symbol name);
    int index_of_method_with_name(Symbol name);
    attr_class *attr_at_index(int idx);
    attr_class *attr_with_name(Symbol name);
    ClassMethodPair method_at_index(int idx);
    ClassMethodPair method_with_name(Symbol name);

    void set_tag(int x){ object_tag = x; }
    int get_tag(){ return object_tag; }
    void set_obj_size(int x){ object_size = x; }
    int get_obj_size(){ return object_size; }
    void code_layout();
};

class BoolConst
{
  private: 
    int val;
  public:
    BoolConst(int);
    void code_def(ostream&, int boolclasstag);
    void code_ref(ostream&) const;
};

