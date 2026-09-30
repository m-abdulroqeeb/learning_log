# =================================================================
# Data Structures
# =================================================================
# What is a data structure?
# It is a way of organizing and storing data so it can be used efficiently.
# In python, we have built in data structures: list[] (collection of common items),
# tuple() (no changes allowed), set{} (all values must be unique), dict{} (key value pairs)

# List
# How to create a new list?

empty = []  # An empty list
print(empty)
print(type(empty))  # print the data type

letters = ['a', 'b', 'c']
print(letters)

numbers = [1, 2, 3]
print(numbers)

mixed_list = ['a', 1, True, None]  # a list can hold mixed data types, unlike some languages
print(mixed_list)

# Another way to create a list
empty = []
print(empty)

letters = 'Python'
print(letters)

letters = list('python')  # list() splits a string into a list of its individual characters
print(letters)

numbers = list(range(10))  # list() can also turn a range into an actual list of numbers
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