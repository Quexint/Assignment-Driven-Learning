#!/usr/bin/env python
import sys
import math
# INSTRUCTIONS !
# The provided code calculates phi coefficients for each code line.
# Make sure that you understand how this works, then modify the provided code
# to work also on function calls (you can use your code from problem set 5 here)
# Use the mystery function that can be found at line 170 and the
# test cases at line 165 for this exercise.
# Remember that for functions the phi values have to be calculated as
# described in the problem set 5 video -
# you should get 3 phi values for each function - one for positive values (1),
# one for 0 values and one for negative values (-1), called "bins" in the video.
#
# Then combine both approaches to find out the function call and its return
# value that is the most correlated with failure, and then - the line in the
# function. Calculate phi values for the function and the line and put them
# in the variables below.
# Do NOT set these values dynamically.

answer_function = "f2"   # One of f1, f2, f3
answer_bin = -1          # One of 1, 0, -1
answer_function_phi = 0.6547 # precision to 4 decimal places.
# if there are several lines with the same phi value, put them in a list,
# no leading whitespace is required
answer_line_phi = 1.0000# precision to 4 decimal places.
# How to compute answer_line_phi
# global_answer_line_phi = answer_function_phi * answer_line_phi
# answer_line_phi = global_answer_line_phi / answer_function_phi
# answer_line_phi = 0.6547 / 0.6547 = 1.000
answer_line = ["elif other < 1:", "grade -= 1"]  # lines of code


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


# global variable to keep the coverage data in
coverage = {}
# Tracing function that saves the coverage data
# To track function calls, you will have to check 'if event == "call"', and in
# that case the variable arg will hold the return value of the function,
# and frame.f_code.co_name will hold the function name
def traceit(frame, event, arg):
    global coverage

    if event == "line":
        filename = frame.f_code.co_filename
        lineno   = frame.f_lineno
        if not coverage.has_key(filename):
            coverage[filename] = {}
        coverage[filename][lineno] = True

    return traceit

# Calculate phi coefficient from given values
def phi(n11, n10, n01, n00):
    return ((n11 * n00 - n10 * n01) /
             math.sqrt((n10 + n11) * (n01 + n00) * (n10 + n00) * (n01 + n11)))

# Print out values of phi, and result of runs for each covered line
def print_tables(tables):
    for filename in tables.keys():
        lines = open(filename).readlines()
        for i in range(31, 47): # lines of the remove_html_markup in this file
            if tables[filename].has_key(i + 1):
                (n11, n10, n01, n00) = tables[filename][i + 1]
                try:
                    factor = phi(n11, n10, n01, n00)
                    prefix = "%+.4f%2d%2d%2d%2d" % (factor, n11, n10, n01, n00)
                except:
                    prefix = "       %2d%2d%2d%2d" % (n11, n10, n01, n00)

            else:
                prefix = "               "

            print prefix, lines[i],

# Run the program with each test case and record
# input, outcome and coverage of lines
def run_tests(inputs):
    runs   = []
    for input in inputs:
        global coverage
        coverage = {}
        sys.settrace(traceit)
        result = remove_html_markup(input)
        sys.settrace(None)

        if result.find('<') == -1:
            outcome = "PASS"
        else:
            outcome = "FAIL"

        runs.append((input, outcome, coverage))
    return runs

# Create empty tuples for each covered line
def init_tables(runs):
    tables = {}
    for (input, outcome, coverage) in runs:
        for filename, lines in coverage.iteritems():
            for line in lines.keys():
                if not tables.has_key(filename):
                    tables[filename] = {}
                if not tables[filename].has_key(line):
                    tables[filename][line] = (0, 0, 0, 0)

    return tables

# Compute n11, n10, etc. for each line
def compute_n(tables):
    for filename, lines in tables.iteritems():
        for line in lines.keys():
            (n11, n10, n01, n00) = tables[filename][line]
            for (input, outcome, coverage) in runs:
                if coverage.has_key(filename) and coverage[filename].has_key(line):
                    # Covered in this run
                    if outcome == "FAIL":
                        n11 += 1  # covered and fails
                    else:
                        n10 += 1  # covered and passes
                else:
                    # Not covered in this run
                    if outcome == "FAIL":
                        n01 += 1  # uncovered and fails
                    else:
                        n00 += 1  # uncovered and passes
            tables[filename][line] = (n11, n10, n01, n00)
    return tables

# Now compute (and report) phi for each line. The higher the value,
# the more likely the line is the cause of the failures.

# These are the test cases for the remove_html_input function
# Exsamples
inputs_line = ['foo',
          '<b>foo</b>',
          '"<b>foo</b>"',
          '"foo"',
          "'foo'",
          '<em>foo</em>',
          '<a href="foo">foo</a>',
          '""',
          "<p>"]
runs = run_tests(inputs_line)
tables = init_tables(runs)
tables = compute_n(tables)
print_tables(tables)

# These are the input values you should test the mystery function with
inputs = ["aaaaa223%", "aaaaaaaatt41@#", "asdfgh123!", "007001007", "143zxc@#$ab", "3214&*#&!(", "qqq1dfjsns", "12345%@afafsaf"]

###### MYSTERY FUNCTION
def mystery(magic):
    assert type(magic) == str
    assert len(magic) > 0

    r1 = f1(magic)
    r2 = f2(magic)
    r3 = f3(magic)

    print magic, r1, r2, r3

    if r1 < 0 or r3 < 0:
        return "FAIL"
    elif (r1 + r2 + r3) < 0:
        return "FAIL"
    elif r1 == 0 and r2 == 0:
        return "FAIL"
    else:
        return "PASS"


def f1(ml):
    if len(ml) <6:
        return -1
    elif len(ml) > 12 :
        return 1
    else:
        return 0

def f2(ms):
    digits = 0
    letters = 0
    for c in ms:
        if c in "1234567890":
            digits += 1
        elif c.isalpha():
            letters += 1
    other = len(ms) - digits - letters
    grade = 0

    if (other + digits) > 3:
        grade += 1
    elif other < 1:
        grade -= 1

    return grade

def f3(mn):
    forbidden = ["pass", "123", "qwe", "111"]
    grade = 0
    for word in forbidden:
        if mn.find(word) > -1:
            grade -= 1
    if mn.find("%") > -1:
        grade += 1
    return grade

################ MY SOLUTION ################ 
coverage_mystery_line = {}
coverage_mystery_func = {}
def print_tables_mystery(tables):
    for filename in tables.keys():
        lines = open(filename).readlines()
        for i in range(167, 222):
            if tables[filename].has_key(i + 1):
                (n11, n10, n01, n00) = tables[filename][i + 1]
                try:
                    factor = phi(n11, n10, n01, n00)
                    prefix = "%+.4f%2d%2d%2d%2d" % (factor, n11, n10, n01, n00)
                except:
                    prefix = "       %2d%2d%2d%2d" % (n11, n10, n01, n00)

            else:
                prefix = "               "

            print prefix, lines[i],

def traceit_mystery(frame, event, arg):
    global coverage_mystery_line, coverage_mystery_func

    if event == "return":
        func_name = frame.f_code.co_name
        if func_name != 'mystery':
            if func_name not in coverage_mystery_func:
                coverage_mystery_func[func_name] = {-1:0, 0:0, 1:0}
            print event, func_name, arg
            if arg > 0:
                coverage_mystery_func[func_name][1] = coverage_mystery_func[func_name][1] + 1
            elif arg == 0:
                coverage_mystery_func[func_name][0] = coverage_mystery_func[func_name][0] + 1
            elif arg < 0:
                coverage_mystery_func[func_name][-1] = coverage_mystery_func[func_name][-1] + 1

    if event == "line" and frame.f_code.co_name == 'f2':
        filename = frame.f_code.co_filename
        lineno   = frame.f_lineno
        if not coverage_mystery_line.has_key(filename):
            coverage_mystery_line[filename] = {}
        coverage_mystery_line[filename][lineno] = True


    return traceit_mystery

def run_tests_mystery(inputs):
    runs_line = []
    runs_func = []
    for input in inputs:
        global coverage_mystery_line, coverage_mystery_func
        coverage_mystery_line = {}
        coverage_mystery_func = {}
        sys.settrace(traceit_mystery)
        result = mystery(input)
        sys.settrace(None)

        runs_line.append((input, result, coverage_mystery_line))
        runs_func.append((input, result, coverage_mystery_func))

    return (runs_line, runs_func)

def init_tables_func(runs_func):

    tables = {}
    for input, outcome, result in runs_func:
        for func_name in result:
            if func_name not in tables:
                tables[func_name] = {-1:(0,0,0,0), 0:(0,0,0,0), 1:(0,0,0,0)}
    return tables

def compute_n_func(tables):

    for input, outcome, result in runs_func:
        for func_name in result:
            sum_val = result[func_name][-1] + result[func_name][0] + result[func_name][1]
            for key, val in result[func_name].iteritems():
                (n11, n10, n01, n00) = tables[func_name][key]
                if outcome == 'FAIL':
                    n11 += val
                    n01 += (sum_val - val)
                else:
                    n10 += val
                    n00 += (sum_val - val)
                tables[func_name][key] = (n11, n10, n01, n00)

    return tables

def print_tables_mystery_func(tables):

    for func_name in tables:
        for val in tables[func_name]:
            (n11, n10, n01, n00) = tables[func_name][val]
            try:
                ans = phi(n11, n10, n01, n00)
                print "Func", func_name, "Val", val, "%+.4f" %(ans)
            except:
                ans = None
                print "Func", func_name, "Val", val, "None"

(runs, runs_func) = run_tests_mystery(inputs)
# For Function Phi Function
tables = init_tables_func(runs_func)
tables = compute_n_func(tables)
print_tables_mystery_func(tables)
# For Line Phi Function
tables = init_tables(runs)
tables = compute_n(tables)
print_tables_mystery(tables)
