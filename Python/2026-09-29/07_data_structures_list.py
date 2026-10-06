# =================================================================
# Data Structures(List)
# =================================================================
# What is a data structure?
# It is a way of organizing and storing data so it can be used efficiently.
# In python, we have built in data structures: list[] (collection of common items),
# tuple() (no changes allowed), set{} (all values must be unique), dict{} (key value pairs)

# List Characteristics
# - List remembers the order of your values and retains them
# - List allows duplicates
# - List is indexed
# - List values are changeable

# List
# How to create a new list?

import copy
empty = []  # An empty list
print(empty)
print(type(empty))  # print the data type

letters = ['a', 'b', 'c']
print(letters)

numbers = [1, 2, 3]
print(numbers)

# a list can hold mixed data types, unlike some languages
mixed_list = ['a', 1, True, None]
print(mixed_list)

# Another way to create a list
empty = []
print(empty)

letters = 'Python'
print(letters)

# list() splits a string into a list of its individual characters
letters = list('python')
print(letters)

# list() can also turn a range into an actual list of numbers
numbers = list(range(10))
print(numbers)

# Nested List: a list that contains other lists as its items
matrix = [['a', 'b', 'c'],
          ['d', 'e', 'f']]
print(matrix)
print(type(matrix))

mixed_matrix = [[1, 2, 3],
                ['a', 'b'],
                [True]]  # nested lists don't need to be the same length or type
print(mixed_matrix)
print(type(mixed_matrix))

# Access & Read
lst = ['a', 'b', 'c', 'd']
print(lst)  # Reading the list
print(lst[-1])  # Reading a specific item in the list

# How to access and read a matrix
matrix = [
    ['a', 'b', 'c'],  # Row 0
    ['d', 'e', 'f'],  # Row 1
    ['g', 'h', 'i']   # Row 2
]

# print(matrix)
print(matrix[-1])  # print last row
print(matrix[2][2])  # Get the last item of the last row
print(matrix[0][0])  # Get the first item of the first row
print(matrix[1][1])  # To get e

# Slicing
lst = ['a', 'b', 'c', 'd']
print(lst)
print(lst[0])
print(lst[-1])
print(lst[-2])
print(lst[:2])
# TASK: Get the last two characters
print(lst[-2:])

matrix = [
    ['a', 'b', 'c'],  # Row 0
    ['d', 'e', 'f'],  # Row 1
    ['g', 'h', 'i']   # Row 2
]
# TASK: print the first two lists
print(matrix[0:2])
print(matrix[1:])  # print the last two lists
print(matrix[2][:2])  # print g and h in row 2

# How to unpack
# Unpacking assigns each item in a list to its own variable, in order, in one line
person = ['Maria', 29, 'Data Engineer', 'Spain']
name = person[0]
age = person[1]
role = person[2]
country = person[3]

# Alternative using unpacking
name, age, role, country = person  # the order is really important
print(name, age, role, country)

# To get the first and last items
# Using * to capture everything between the first and last items into its own list
name, *details, country = person
print(name)
print(details)
print(country)

# To get only the first item
name, *details = person
print(name)
print(details)

# Unpacking Rules in Python
# The number of variables must match the number of values in the item

# Skipping Items: underscore _
# _ is used as a throwaway variable name, a convention meaning "I don't need this value"
person = ['Maria', 29, 'Data Engineer', 'Spain']

name, _, role, _ = person
print(role)

# Explore and Analyze list
numbers = [1, 0, 2, 4, 5, 6, 3, 5]
# Max: To find the highest value in the list
print('Max:', max(numbers))
# Min: To find the lowest value in the list
print('Min:', min(numbers))
# sum: To find the summation of the list values
# It won't work if not all values are numeric
print('Sum:', sum(numbers))
# len: To find the length of values in the list
print('Length:', len(numbers))
# all: checks if every value is truthy (returns False here because 0 is falsy, even though it's a real value)
print('All:', all(numbers))
print('All:', all(['a', 'c', 'b']))
# Any: To check if at least one value is truthy
print('Any:', any(numbers))
print('Any:', any(['', '', None]))
# .count: How many times a value appears in the list
print('Count:', numbers.count(5))
# .index: To return the position of the first time a value appears in your list
print('Index: ', numbers.index(5))
# In: To check if a value is present in a list
print(4 in numbers)
print(10 in numbers)

# Change your list
# How to add items?

# .append(): To add a value to the end of a list
letters = ['a', 'b', 'c']
letters.append('v')
letters.append('y')
print(letters)

# How to insert at a specific position

# Add 'x' at the start of the list
letters = ['a', 'b', 'c']
letters.insert(0, 'x')
print(letters)

# Add 'y' between 'b' and 'c'
letters.insert(3, 'y')
print(letters)

matrix = [
    ['a', 'b', 'c'],  # Row 0
    ['d', 'e', 'f'],  # Row 1
    ['g', 'h', 'i']   # Row 2
]
matrix.append(['x', 'y', 'z'])
matrix.insert(0, ['x', 'y', 'z'])
print(matrix)

# Add 'x' at the end of the second row
matrix[1].append('x')
print(matrix)
matrix[0].insert(0, 'z')
print(matrix)

# Remove item in your list
# .clear() to erase all the values in a list
letters.clear()
print(letters)

# .remove(): To remove a specific value, only the first match will be removed
letters = ['a', 'b', 'a']
# TASK: Remove 'a' from the list
letters.remove('a')
# letters.remove('a')
print(letters)

# .pop(): To remove something sitting on a specific spot
# If you don't specify the index, by default it will remove the last value
# .pop() doesn't just remove, it also returns what was removed
letters = ['a', 'b', 'c']
# remove the last value
removed = letters.pop()
print(letters)
print(removed)
# remove 'b' using .pop()
letters = ['a', 'b', 'a']
removed = letters.pop(1)
print(letters)
print(removed)

# Using the Matrix as an example
# .remove() demonstration on its own, removing a row by its actual value
matrix = [
    ['a', 'b', 'c'],  # Row 0
    ['d', 'e', 'f'],  # Row 1
    ['g', 'h', 'i']   # Row 2
]
matrix.remove(['a', 'b', 'c'])
print(matrix)

# .pop() demonstration on its own, using a fresh matrix so only one row is removed
matrix = [
    ['a', 'b', 'c'],  # Row 0
    ['d', 'e', 'f'],  # Row 1
    ['g', 'h', 'i']   # Row 2
]
# To remove the last list
matrix.pop()
print(matrix)

matrix = [
    ['a', 'b', 'c'],  # Row 0
    ['d', 'e', 'f'],  # Row 1
    ['g', 'h', 'i']   # Row 2
]
# to remove a specific value in a row
matrix[0].remove('a')
print(matrix)
# to remove the last value in the last row
removed = matrix[2].pop()
print(matrix)
print(removed)
# to remove 'e' from row 1 using .pop()
removed = matrix[1].pop(-2)
print(removed)
print(matrix)

# Update Items
# No dedicated function or method for updating values
letters = ['a', 'b', 'a']
letters[0] = 'c'
print(letters)  # We are simply overwriting the value

# TASK: Update the content of the last list
matrix = [
    ['a', 'b', 'c'],  # Row 0
    ['d', 'e', 'f'],  # Row 1
    ['g', 'h', 'i']   # Row 2
]

matrix[-1] = ['x', 'y', 'z']
print(matrix)

# Update one specific value from the list
matrix[0][0] = '-'
print(matrix)

# Sorting List
# .sort()
letters = ['a', 'b', 'z', 'x']
letters.sort(reverse=True)
print(letters)

matrix = [
    ['a', 'b', 'c'],  # Row 0
    ['g', 'b', 'i'],  # Row 1
    ['d', 'i', 'f']   # Row 2
]
matrix.sort()  # For this, python compares the lists against each other by their values
print(matrix)

# to sort a specific inner list
matrix[2].sort()
print(matrix)

# TASK: Sort the data without changing the original list
new_list = sorted(letters)
print('Original:', letters)
print('New List:', new_list)

# Reversing List
# To flip the list order around
print('\nNew List:', new_list)
new_list.reverse()
print('Reverse New List:', new_list)

reverse_new_list = list(reversed(new_list))
print('Reverse New List:', new_list)
print('\n')
# Copying List
# Assignment: Python will not create a new list, both variables reference the same list in memory
# Any change in either copy or original list will have an effect on both
letters = ['a', 'b', 'c', 'd']
letters_copy = letters
letters_copy.append('x')
print('Original:', letters)
print('copy:', letters_copy)
print('\n')

# Shallow Copy: creates a separate list in memory, but its inner elements still point to the same objects
# The copy is not that deep
letters = ['a', 'b', 'c', 'd']
letters_copy = letters.copy()
letters_copy.append('x')
print('Original:', letters)
print('copy:', letters_copy)
print('\n')

# Deep Copy:
# To achieve a deep copy we first need to import the copy module
matrix = [
    ['a', 'b'],  # Row 0
    ['c', 'd']  # Row 1
]
matrix_copy = copy.deepcopy(matrix)
matrix_copy.pop()
# TASK: Add a new item in the 1st row of the copied list
matrix_copy[0].append('z')
print('Original:', matrix)
print('Copy:', matrix_copy)
print('\n')

# The copy module also has a function called copy(), it works exactly like shallow copy
matrix_copy = copy.copy(matrix)
matrix_copy.pop()
# TASK: Add a new item in the 1st row of the copied list
matrix_copy[0].append('z')
print('Original:', matrix)
print('Copy:', matrix_copy)

# Testing: to check if original and copy lists are sharing the same list or are independent
# This can be done using the 'is' operator

original = [
    ['a', 'b'],  # row 0
    ['c', 'd']  # row 1
]

# Assignment
copy1 = original
print('Same Object?', copy1 is original, '\n')

# Shallow copy
copy2 = original.copy()
print('Same Object?', copy2 is original)
print('Shared Lists?', original[0] is copy2[0], '\n')

# Deep Copy
copy3 = copy.deepcopy(original)
print('Same Object?', copy3 is original)
print('Shared Lists?', original[0] is copy3[0], '\n')

# Combining Lists
# + joins two lists end to end (concatenation), it does not add values element by element like math addition
letters = ['a', 'b', 'c']
numbers = [1, 2, 3]

comb = letters + numbers
print(comb)
comb = [letters, numbers]
print(comb)
print([letters] * 2)
# extend() doesn't create a new list, it expands the original one in place
numbers.extend(letters)
print(letters)
print(numbers)
print('\n')

letters = ['a', 'b', 'c']
numbers = [1, 2, 3]

comb = zip(letters, numbers, 'Hi')  # pairs items from multiple sequences together into tuples
print(list(comb))
print('\n')


id = [101, 102, 103]
names = ['Ali', 'Sara', 'John']
# TASK: Pair customers with their IDs (rebuild the relationship)
identity = list(zip(id, names))  # tuple
print(identity)

# How to iterate through our list?
# Why do we need iterators?
# 1. In order to build a loop
# 2. In order to save memory
# 3. For speed and flexibility
# What is the difference between iterable and iterator?
# An iterator is an object that helps us actually do the iteration
# An iterable is anything we can loop over

# We use iteration for transformation of data
# TASK: Store the transformed data in a new list
letters = ['a', 'b', 'c']
new_list = []
for l in letters:
    new_list.append(l.upper())
    print(new_list)


# Enumerate, reversed, zip
letters = ['a', 'b', 'c']
print(list(enumerate(letters, start=1)))
for index, value in enumerate(letters):
    print(index, value)


# Reversed: Returns an iterator that flips the data order
letters = ['a', 'b', 'c']
numbers = [1, 2, 3]
print('\n')
print(letters)
print(list(reversed(letters)))
for r in reversed(letters):
    print(r)

# zip
print(list(zip(numbers, letters)))
for k, p in zip(numbers, letters):
    print(k, p)

# map
# TASK: Make every item uppercase
letters = ['a', 'b', 'c']
print(list(map(str.upper, letters)))

numbers = ['1', '2', '3']
# Task: Convert list items to integers
print(list(map(int, numbers)))


names = [' Maria ', ' John ', '  Kumar   ']
# Task: Clean up the list by removing all unwanted spaces
for n in map(str.strip, names):
    print(n)

# Filter: is perfect for cleaning up unwanted data in your structures
letters = ['a', 'b', 'c', None, '']
# Clean up the list by removing invalid data
# None as the function: removes all falsy values, 0, '', or False, bool does the same check
print(list(filter(None, letters)))

items = ['sql', '123', 'python', '42']
# TASK: Keep only numbers
print(list(filter(str.isnumeric, items)))
# TASK: Keep only letters
print(list(filter(str.isalpha, items)))
for i in filter(str.isalpha, items):
    print(i)

# Lambda Function: a tiny function without a name, also called an anonymous function
# With a single line you can define a whole function


# Variable(multiple) stores a lambda function which doubles a number
def multiple(x): return x * 2


print(multiple(3))


def add(x, y): return x + y


# When a lambda has two parameters, you must pass two values when calling it.
print(add(2, 3))

print(add(2, 4))

# A lambda can contain any expression, including a condition


def check(i): return i in 'python'


print(check('n'))

# Lambda + map
prices = ['$12.50', '$9.99', '$100.00']
# TASK: Prices are stored as messy strings and need cleaning to floats
print(list(map(lambda p: float(p.replace('$', '')), prices)))


# lambda + filter
prices = [120, 30, 300, 80]
# TASK: Remove all prices lower than 100
print(list(filter(lambda p: p >= 100, prices)))

students = [
    ['Maria', 85],
    ['Kumar', 90],
    ['Max', 60]
]
# TASK: Keep only students with scores higher than 70
print(list(filter(lambda row: row[1] > 70, students)))

# Challenge
# Keep only students with names starting with 'M'
students = [
    ['Maria', 85],
    ['Kumar', 90],
    ['Max', 60]
]
print(list(filter(lambda row: row[0].startswith('M'), students)))


# List Comprehension
# Transformation > Loop > Filter

domain = ['www.google.com', 'openai.com', 'localhost', 'WWW.OPEYEMI.COM']
# TASK: Normalize the domains into standard format

cleaned = [
    # Data Transformation
    d.lower().replace('www.', '')
    # For Loop
    for d in domain
    # Data Filtering
    if '.' in d
]


# Personal Challenge
# Sort each list in the matrix
matrix = [
    [9, 8, 0, 2, 4],
    [4, 45, 6, 6, 2],
    [34, 4, 5, 3, 5]
]
[matrix[i].sort() for i in range(0, 3)]
print(matrix)