#!/usr/bin/env python
# Simple debugger
# See instructions around line 85
import sys
import readline

# Our buggy program
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
    
# main program that runs the buggy program
def main():
    print remove_html_markup('"<b>foo</b>"')

# globals
breakpoints = {}
watchpoints = {"quote": True}
watch_values = {}
stepping = True

"""
Our debug function
"""
def debug(command, my_locals):
    global stepping
    global breakpoints
    
    if command.find(' ') > 0:
        arg = command.split(' ')[1]
    else:
        arg = None

    if command.startswith('s'):     # step
        stepping = True
        return True
    elif command.startswith('c'):   # continue
        stepping = False
        return True
    elif command.startswith('p'):    # print 
        # PS1 CODE From Lesson 1
        if arg == None:
            print my_locals
        elif arg in my_locals:
            print arg, " = ", repr(my_locals[arg])
        else:
            print "No such variable:", arg
    elif command.startswith('b'):    # breakpoint         
        # PS1 CODE From Lesson 1
        if arg != None:
            breakpoints[int(arg)] = True
        else:
            print 'You must supply a line number'
    elif command.startswith('w'):    # watch variable
        # PS1 CODE From Leson 1
        if arg != None:
            watchpoints[arg] = True
        else:
            print 'You must supply a variable name'
    elif command.startswith('d'):    # delete watch/break point
        # YOUR CODE HERE
        val_str = command.split(' ')[2]
        if arg == 'b':
            if Decimal.is_normal(Decimal(val_str)) and Decimal(val_str) in breakpoints:
                del breakpoints[Decimal(val_str)]
            else:
                print "No such breakpoint defined", repr(argument)
        elif arg == 'w':
            if val_str in watchpoints:
                del watchpoints[val_str]
            else:
                print val_str, "is not defined as watchpoint"
        else:
            print "Incorrect command"
    elif command.startswith('q'):   # quit
        print "Exiting my-spyder..."
        sys.exit(0)
    else:
        print "No such command", repr(command)
    return False

commands = ["w c", "c", "c", "w out", "c", "c", "c", "q"]

def input_command():
    #command = raw_input("(my-spyder) ")
    global commands
    command = commands.pop(0)
    return command

"""
Our traceit function
Improve the traceit function to watch for variables in the watchpoint 
dictionary and print out (literally like that): 
event, frame.f_lineno, frame.f_code.co_name
and then the values of the variables, each in new line, in a format:
somevar ":", "Initialized"), "=>", repr(somevalue)
if the value was not set, and got set in the line, or
somevar ":", repr(old-value), "=>", repr(new-value)
when the value of the variable has changed.
If the value is unchanged, do not print anything.
"""
def traceit(frame, event, trace_arg):
    global stepping

    if event == 'line':
        if stepping or breakpoints.has_key(frame.f_lineno):
            resume = False
            while not resume:
                print event, frame.f_lineno, frame.f_code.co_name, frame.f_locals
                command = input_command()
                resume = debug(command, frame.f_locals)
        changes = []
        for var, val in frame.f_locals.iteritems():
            if var in watchpoints and watchpoints[var]:
                if (var not in watch_values) or (val != watch_values[var]):
                    changes.append((var, val))
        if len(changes) != 0:
            print event, frame.f_lineno, frame.f_code.co_name
            for var, val in changes:
                if var not in watch_values:
                    print var, ":", "Initialized", "=>", repr(val)
                else:
                    print var, ":", repr(watch_values[var]), "=>", repr(val)
                watch_values[var] = val

    return traceit

# Using the tracer
#sys.settrace(traceit)
#main()
#sys.settrace(None)

# with the commands = ["w c", "c", "c", "w out", "c", "c", "c", "q"],
# the output should look like this (line numbers may be different):
#line 26 main {}
#line 10 remove_html_markup
#quote : Initialized => False
#line 13 remove_html_markup
#c : Initialized => '"'
#line 19 remove_html_markup
#quote : False => True
#line 13 remove_html_markup
#c : '"' => '<'
#line 21 remove_html_markup
#out : '' => '<'
#Exiting my-spyder...
