# ===========================================================================
# WORKING WITH STRINGS (in progress)
# ===========================================================================
# String Categories
# 01_ Types: type(), str()
# 02_ Math: len(), count()
# 03_ Transformation: replace(), 'H' + 'i', f{}, split(), 'ha' * 2, extraction, 'cat'[0], 'cat'[1:3]

print('\n')

# ---------------------------------------------------------------------
# Types
# type(): checks the data type of a variable
# str(): converts any value into a string
# ---------------------------------------------------------------------
name = 'Opeyemi'
print(type(name))

age = 24
print(type(age))
print('Your Age is: ' + str(age))  # str() needed here because it can't concatenate a string with an int directly
age = age + 5
age = str(age)  # age is now a string, not an int anymore
print(type(age))
print('\n')

# ---------------------------------------------------------------------
# Math (string versions)
# len(): length of a value
# ---------------------------------------------------------------------
password = '123qwer4d'
print(len(password))
if len(password) < 8:
    print('this password is too short!')

text = '''
Python is easy to learn.
Python is powerful
Many people love Python
'''
# count(): counts how many times a substring appears (not just single characters)
print(text.count('Python'))
print(text.count('$'))
print('\n')

# ---------------------------------------------------------------------
# Transformations
# replace(): swaps one substring for another
# ---------------------------------------------------------------------
price = '1234,56'
print(price.replace(',', '.'))

phone = '176-123-56'
print(phone.replace('-', '/'))
print(phone.replace('-', ''))  # Replacing the old value with an empty string removes it entirely

price = '$1,299.99'
print(price.replace('$', '').replace(',', ''))
# Chained methods run in order, left to right.
# Each replace() operates on the result of the one before it.

# Class Work
print('''
CLASS WORK
Convert the messy phone number into a clean number format with only digits.
From '+40 (176) 123 - 4567' to 0401761234567
''')

phone = '+40 (176) 123 - 4567'
print(phone.replace('+', '00').replace(')', '').replace('(', '').replace('-', '').replace(' ', ''))
