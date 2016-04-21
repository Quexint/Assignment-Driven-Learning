# Write a function, `evaluate_calls`
# that evaluates all calls in the CALLS
# variable.
#
# The ouput should be in the form:
#     function(args) = value
# for each element in CALLS
#

CALLS = ["remove_html_markup(s = '<b>foo</b>')", "square_root(x = 2)"]

def evaluate_calls():
    for ith_call in CALLS:
        ret = eval(ith_call)
        print ith_call, "=", repr(ret)

###
# To test your code, run evaluate_calls and see that
# it prints out:
# remove_html_markup(s = '<b>foo</b>') = 'foo'
# square_root(x = 2) = 1.4142135623730951

###################
# Code for recording calls
#

import sys
import math

def remove_html_markup(s):
    tag   = False
    quote = False
    out   = ""

    for c in s:
        if c == '<' and not quote:
            tag = True
        elif c == '>' and not quote:
            tag = False
        elif c == '"':
            quote = not quote
        elif not tag:
            out = out + c
    return out

def square_root(x, eps = 0.00001):
    assert x >= 0
    y = math.sqrt(x)
    assert abs(y * y - x) <= eps
    return y

def pretty_locals(local_args):
    """Return local_args in a format suitable for calls"""
    ret = ""
    for name, value in local_args.iteritems():
        if ret != "":
            ret = ret + ", "
        ret = ret + name + " = " + repr(value)
    return ret

def pretty_call(frame):
    return (frame.f_code.co_name +
            "(" + pretty_locals(frame.f_locals) + ")")

def traceit(frame, event, arg):
    global calls
    if event == "call":
        print pretty_call(frame)
        calls.append(pretty_call(frame))

    return traceit

