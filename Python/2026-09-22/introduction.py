# ===========================================================================
# PYTHON INTRODUCTION : Print statements, comments, variables, data types
# ===========================================================================

print('Hi, this is my first python code')

# This is a comment: ignored by Python, used for notes/explanations

# Store the final exam score
x = 10
x = 9  # Final exam score (overwritten: variables can be reassigned)

print("Hi Python")
print('Hello Python')  # Single and double quotes both work for strings

# print ("Hi")  # Commented-out code : doesn't run, kept for reference
print("----------------------------")
print('....LEARN PYTHON.......')

# Escaping quotes inside strings
# \' escapes a single quote; \- is not a real escape sequence
print("-------------\'--'\-------------")
# \' lets you use a single quote inside a single-quoted string
print('HI \'Python\'')
# \" escapes a double quote (not strictly needed here, since we're in single quotes)
print('Hi \"Python\"')

# Escaping backslashes (common in file paths)
print("Path: C:\\User\\Baraa")  # \\ prints a single literal backslash

# \t = tab character
print('message1 \t aaa')
print('message2')
print('message\tmessage')

# PYTHON CHALLENGE
# Use PRINT() to recreate this exact output
# You are allowed to use only one print
print('''Your Learning Path: 
\t-Python Basics  
\t-Data Engineerin  
\t-AI''')

# ---------------------------------------------------------------------
# print() use cases — printing multiple values, variables
# ---------------------------------------------------------------------
print('My name is Opeyemi')
print('Opeyemi is learning python')
print('Opeyemi wants to become python expert\n')  # \n adds a blank line after

name = 'Akande'
language = 'JAVA'
# print() can take multiple comma-separated values
print('My name is', name)
print(name, 'is learning', language)
print(name, 'wants to become', language, 'expert')

# input() pauses the program and waits for the user to type something
name = input('Enter Your Name: ')
country = 'Germany'
print(name, 'comees from ', country)

# ---------------------------------------------------------------------
# Basic data types
# ---------------------------------------------------------------------
a = 10        # int
b = 3.15      # float
c = 'Hello'   # str
d = 'hi'      # str
e = '1234'    # str : this is text, NOT a number, even though it looks like one

# bool — reassigning 'a'; True/False are case sensitive (true/false won't work)
a = True
b = False     # bool - reassigning 'b'
h = None      # NoneType — represents "no value at all"
i = ''        # str — empty string (zero characters, len = 0)
# str — blank (contains only whitespace, len = 1, NOT the same as empty)
j = ' '

text = 'hi'
number = 10

print(type(text))
# print(len(number))  # Commented out on purpose — len() doesn't work on an int, only on sequences like strings

print(text.upper())

# bit_length(), type(), len() — different methods for different data types
age = 21
height = 14
name = 'Opeyemi'
student = 'Yes'
job = 'NO'

# bit_length() only works on integers
print(age, type(age), age.bit_length())
print(height, type(height), height.bit_length())
# len() only works on strings/sequences
print(name, type(name), len(name))
print(student, type(student), len(student))
print(job, type(job), len(job))
