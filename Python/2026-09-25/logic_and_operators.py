# ===========================================================================
# LOGIC AND OPERATORS
# ===========================================================================
# Control is like the logic in your code that controls how your code runs
# Conditional Statements
# control flow tools:
# control flow statement: conditional statements (if, else, elif)
# and loop types (for, while), loop control (break, pass, continue)
# Boolean Expression: Values (True, False), Functions (bool(), any(), all(), isinstance()),
# Comparison operators (==, !=, <, >, >=, <=), logical operators (and, or, not),
# membership operators (in, not in), identity operators (is, is not)

# Boolean
print(True)
print(False)
print(type(True))
print(bool(123))  # here bool checks if you have an empty value or not
print(bool())  # this is False because it is empty
print(bool(0))  # Zero is a value, but bool considers it as nothing
print(bool(''))  # This is going to be False
print(bool(None))  # None is considered missing, the real nothing

email = ''
phone = ''
username = ''

print(any([email, phone, username]))  # any (should have at least one True)

email = ''
phone = ''
username = ''
# all (every variable must be True for the result to be True)
print(all([email, phone, username]))

print(isinstance(123, int))
print(isinstance(True, str))

print('Hello'.endswith('o'))
print('Hello'.startswith('o'))

# Comparison Operator: it compares two values and returns True or False depending on the result
print(10 == 10)
print(10 != 10)
print(7 > 3)
print(7 >= 3)
print(3 < 7)
print(3 <= 7)
print(7 == 7)

print('a' < 'b')

print('a' == 'b')

# chain comparison
print(1 < 4 < 6)

# Is age between 18 and 30
age = 35
print(18 <= age <= 30)

# logical operators: used to combine multiple boolean expressions
# and: Both must be True
# or: At least one must be True
# not: It reverses the truth. It turns True into False and False into True
print(3 > 1 and 5 < 1)
print(3 > 1 or 5 < 1)

# Check if the system is under pressure
cpu_usage = 70
memory_usage = 95
print(cpu_usage > 90 or memory_usage > 90)

# Checking user credentials before login
email = True
password = True
print(email and password)

# not

print(not 3 > 2)
print(not False)

name = ''
print(not name)
print(not 0)

# execution order
# 'and' has higher priority than 'or'

# TASK
# Allow access only if the user is logged in
# or they are a guest, but they must not be banned

is_logged_in = True
is_guest = False
is_banned = False

print(is_logged_in or is_guest and not is_banned)

# Membership operators: check if a value exists inside a sequence (string, list, etc.)
# in: True if the value is found
# not in: True if the value is NOT found

print('f' not in 'python')
print(3 in [1, 2, 3])

# Validate that the domain is not on the banned list
# Security check: ensure the domain is not banned

# Validate that the domain is not on the banned list
# Security check: ensure the domain is not banned

domain = 'spam.com'
banned_domains = ['spam.com', 'fake.org', 'bot.net']
print(domain not in banned_domains)

# Identity operator: Check if two variables are referring to the same object in memory

# is
# is not