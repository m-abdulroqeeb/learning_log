# ===========================================================================
# WORKING WITH STRINGS (In Progress)
# ===========================================================================
# String Categories
# 01_ Types: type(), str()
# 02_ Math: len(), count()
# 03_ Transformation: replace(), 'H' + 'i', f{}, split(), 'ha' * 2, extraction, 'cat'[0], 'cat'[1:3]
# 04_ Cleaning: lstrip(), rstrip(), strip(), lower(), upper()
# 05_ Search startswith(), endswith(), find(), 'in'
# 06_ Validation: isalpha(), isnumeric()

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
# str() needed here because it can't concatenate a string with an int directly
print('Your Age is: ' + str(age))
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
# string + string
# f-string
# split()
# string repetition
# Extraction
# ---------------------------------------------------------------------
price = '1234,56'
print(price.replace(',', '.'))

phone = '176-123-56'
print(phone.replace('-', '/'))
# Replacing the old value with an empty string removes it entirely
print(phone.replace('-', ''))

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
print(phone.replace('+', '00').replace(')',
      '').replace('(', '').replace('-', '').replace(' ', ''))

# string + string
first_name = 'Michael'
last_name = 'Scott'
full_name = first_name + " " + last_name
print(full_name)

folder = 'C:/Users/Opeyemi'
file = 'report.csv'
full_path = folder + file
print(full_path)  # Build dynamic file paths

# string
# f-string: Modern, super-easy way to format and build strings
# f stands for formatting
# lets you easily put a variable directly inside a string value without worrying about data type

name = 'Sam'
age = 34
is_student = False

print('My name is ' + name + '. I am ' + str(age) +
      ' years old, and student status is ' + str(is_student))
print(
    f'My name is {name}. I am {age} years old, and student status is {is_student} ')

print(f'2 + 3 = {2 + 3}')

print(f'{{This is me}}')

# split()
# split(): to separate a string. Breaks a string into smaller parts

stamp = '2026-09-20  14:30'
print(stamp.split(' '))

stamp = '2026-09-20  14:30'
print(stamp.split('-'))

csv_file = '1234, max, USA, 1970-10-05,M'
print(csv_file.split(','))

# string repetition: repeat the string multiple times
# It can be used for styling
print('ha' * 3)
print('=' * 60)

# extraction
# Extract the first character
text = 'python'
print(text[0])
# extract the last character
print(text[-1])

# Extract h
print(text[3])

print(text[-3])

date = '2026-09-20'

# Extract the year
print(date[0:4])
print(date[:4])
print(date[:-6])

# Extract the month
print(date[5:7])
print(date[-5:-3])

# Extract the day
print(date[8:])
print(date[-2:])

# Cleaning
# Remove spaces: .strip(), .rstrip(), .lstrip()
# Case conversion

text = 'Engineering     '.rstrip()
print(text)
text = ' Engineering'.lstrip()
print(text)
text = '  Engineering  '.strip()
print(text)

text = 'Data Engineering'.strip()
print(text)

text = '####Abc####'.strip('#')
print(text)

text = ' Engineering '
print(len(text))
print(len(text.strip()))

nr_of_spaces = len(text) - len(text.strip())
is_clean = len(text) == len(text.strip())
print('Nr of Spaces: ', nr_of_spaces)
print('Is my data clean?', is_clean)

# Case Conversion
# It is necessary to prevent case based mismatches during search or comparison
# Always trim spaces and lowercase your data and search term before matching
text = 'Python PROGRAMMING'
print(text.lower())
print(text.upper())

search = 'Email'.lower().strip()
data = 'email'.lower().strip()

print(search == data)

# Challenges

# Turn the messy string into a single clean summary with name, role, and age
# From '968-Maria, (D@t@ Engineer ) ;; 27y  ' to 'name: maria| role: data engineer | age: 27'

text = '968-Maria, (D@t@ Engineer ) ;; 27y  '
text = ('name: ' + text.replace('968-', '').replace(',', '').replace('(',
        '').replace('@', 'a').replace(')', '').replace(';', '').replace('y', '')).strip()
text = text[0:11] + ' | role:' + text[12:25] + ' | age: ' + text[-2:]
print(text)
# Note: added .replace('y', '') to the cleanup chain above, since without it
# the trailing 'y' from '27y' was being captured by text[-2:], producing
# 'age: 7y' instead of 'age: 27'.

# 05_ Search: They produce a boolean result
# startswith(),
# endswith(),
# find(),
# 'in'

# .startswith()
phone = '+49-176-12345'
print(phone.startswith('+49'))

# .endswith()
email = 'baraa@gmail.com'
print(email.endswith('gmail.com'))

file = 'data_backup.csv'
print(file.endswith('.csv'))

# in
# 'in' is a keyword/operator, not a function, it performs a membership test directly
print('@' in email)

url = 'https://api.company.com/v1/data'
print('/api' in url)

# .find():
# great when combined with other methods to build something dynamic.
# It returns the string position of a word in the string

phone1 = '+48-176-12345'
phone2 = '48-654-16548'
phone3 = '0048-654-16548'

# Extract only the phone number without the country code

print(phone1[4:])
print(phone2[3:])

print(phone1.find('-'))
print(phone1[phone1.find('-') + 1:])
print(phone2[phone2.find('-') + 1:])
print(phone3[phone3.find('-') + 1:])

# 06_ Validation:
# isalpha(): check if a string has only letters
# isnumeric(): check if a string has only numbers

# isalpha()
country = 'USA'
print(country.isalpha())
phone = '0987654-345789'
print(phone.isnumeric())

phone = '0987654345789'
print(phone.isnumeric())