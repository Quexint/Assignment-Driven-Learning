#!/usr/bin/env python
import sys
import copy

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

# These are the global variables you will need for this program
# We use these variables to communicate between callbacks and drivers
the_line      = None    # line number of the executed code
the_iteration = None    # iteration number
the_state     = None    # the state of the program and variables

# IMPLEMENT THIS !!!
# This function should trace the function until specified
# line and iteration, and then record the state of the program in
# the_state variable
# Stop at the_line/the_iteration and store frame.f_locals in the_state.
# You can use the following expression to make a copy of frame.f_locals:
# the_state = copy.deepcopy(frame.f_locals)
def trace_fetch_state(frame, event, arg):
    global the_line
    global the_iteration
    global the_state
    if event == "line" and the_line == frame.f_lineno:
        the_iteration = the_iteration - 1
        if the_iteration == 0:
            the_state = copy.deepcopy(frame.f_locals)
    return trace_fetch_state

# This function allows you to get the state of the program
# at specified line and iteration and return it
# Complement to the trace_fetch_state function
# Gets the state at the_line/the_iteration
def get_state(somestr, line, iteration):
    global the_line
    global the_iteration
    global the_state
    
    the_line      = line
    the_iteration = iteration
    
    sys.settrace(trace_fetch_state)
    y = remove_html_markup(somestr)
    sys.settrace(None)
    return the_state


# TESTS
somestr = '"<b>foo</b>"'

# Simple test for line number
the_line = 16
the_iteration = 1
result1 = get_state(somestr, the_line, the_iteration)

# Test to check if you process iterations correctly
the_line = 16
the_iteration = 3
result2 = get_state(somestr, the_line, the_iteration)

# Expected output
correct1 = {'quote': False, 's': '"<b>foo</b>"', 'tag': False, 'c': '"', 'out': ''}
correct2 = {'quote': True, 's': '"<b>foo</b>"', 'tag': False, 'c': 'b', 'out': '<'}

print "Test results are ",
if result1 == correct1 and result2 == correct2:
    print True, "\n", "Try to submit your exercise"
elif result1 == correct1:
    print False, "\n", "Your output is incorrect for the_iteration > 1."
else:
    print False, "\n", "Your output is incorrect for given values. \
                  Please read the supplied comments."


