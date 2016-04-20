#!/usr/bin/env python
import sys
import copy
# See instructions at line 54
# The buggy program
def remove_html_markup(s):
    tag   = False
    quote = False
    out   = ""

    for c in s:
        if c == '<' and not quote:
            tag = True
        elif c == '>' and not quote:
            tag = False
        elif c == '"' or c == "'" and tag:
            quote = not quote
        elif not tag:
            out = out + c

    return out
 

# We use these variables to communicate between callbacks and drivers
the_line      = None
the_iteration = None
the_state     = None
the_diff      = None
the_input     = None

# FILL IN FROM YOUR SOLUTION IN THE PREVIOUS EXERCISE
def trace_fetch_state(frame, event, arg):
    global the_line
    global the_iteration
    global the_state
    # COPY YOUR CODE HERE
    if event == "line" and the_line == frame.f_lineno:
        the_iteration = the_iteration - 1
        if the_iteration == 0:
            the_state = copy.deepcopy(frame.f_locals)
    return trace_fetch_state

# This function allows you to get the state of the program
# at specified line and iteration and return it
def get_state(input, line, iteration):
    global the_line
    global the_iteration
    global the_state
    
    the_line      = line
    the_iteration = iteration
    
    sys.settrace(trace_fetch_state)
    y = remove_html_markup(input)
    sys.settrace(None)
    
    return the_state

# IMPLEMENT THIS !!!
# This function should trace the function until specified
# line and iteration, and then change the value of frame.f_locals
# to the supplied values in the_diff.
# It is crucial to use update() here.  If you will set elements one by one,
# chances are that some changes will get lost. 
# Please use the following syntax to be sure that it works correctly:
# frame.f_locals.update(the_diff)

def trace_apply_diff(frame, event, arg):
    global the_line
    global the_iteration
    global the_diff

    # YOUR CODE HERE
    if event == "line" and the_line == frame.f_lineno:
        the_iteration = the_iteration - 1
        if the_iteration == 0:
            frame.f_locals.update(the_diff)
    return trace_apply_diff
    
    
# Testing function: Call remove_html_output, stop at THE_LINE/THE_ITERATION, 
# and apply the diffs in DIFFS at THE_LINE
def test(diffs):
    global the_diff
    global the_input
    global the_line
    global the_iteration
    
    line      = the_line
    iteration = the_iteration
    
    the_diff = diffs
    sys.settrace(trace_apply_diff)
    y = remove_html_markup(the_input)
    sys.settrace(None)

    the_line      = line
    the_iteration = iteration

    if y.find('<') == -1:
        return "PASS"
    else:
        return "FAIL"
        
html_fail = '"<b>foo</b>"'
html_pass = "'<b>foo</b>'"

def run_tests():
    global the_input
    global the_line
    global the_iteration
    the_input = '"<b>foo</b>"'
    the_line      = 8
    the_iteration = 1
    
    if not test([('s', html_pass)]) == "PASS":
        print "The value 's' was not updated correctly."
        print "Make sure that you use the update() function."
    else:
        print True

    the_line      = 10
    the_iteration = 1
    if not test([('quote', True)]) == "FAIL":
        print "The value 'quote' was not updated correctly"        
    else:
        print True

    the_line      = 16
    the_iteration = 2
    if not test([('tag', True), ('out', '<')]) == "FAIL":
        print "Multiple values were not updated correctly"
    else:
        print True
        
print "Test results:"

run_tests()
