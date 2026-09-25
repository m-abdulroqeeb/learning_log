# ===========================================================================
# WORKING WITH NUMBERS
# ===========================================================================
import math
import random
#  What are numeric values: they are values or datatypes that belong to primitive data type or single value
# Numeric datatype: int - whole number, float - number with decimal point,
# complex - real number + imaginary number
# math operators: +, -, *, /, //, %, **
# Rounding: abs(), round(), ceil(), floor(), trunc
# Advanced Math: sqrt(), sin(), cos(), and log()
# Random: random(), randint()
# Validation: is_integer(), isinstance()

# Types
# type()
# int
# float
# complex

X = 5
Y = 7.9
Z = 2 + 3j
print(type(X))
print(type(Y))
print(type(Z))

x = '24'
print(type(x))
x = int(x)
print(type(x))
print(x*3)

X = 3.14
print(int(X))

X = 3
print(float(X))

x = 3
y = 4

print(complex(x, y))  # For advanced scientific stuff

# Math Operators

print(2 + 3)  # addition
print(5-3)   # Subtraction
print(4 * 2)  # Multiplication
print(7/2)  # Division
print(7//2)  # Floor Division: It divides two numbers and rounds down
print(7 % 2)  # Modulus: To check if our value is odd or even
print(2 ** 3)  # Exponential

x = 2
x = x + 3
print(x)

x = 2
x += 3
print(x)

x -= 3
print(x)

x *= 2
print(x)


# Rounding


# Measure Distance

# ABS
print((2-10))
print(abs(2-10))

# Rounding Numbers
# round(): rounds a number to the nearest whole number up or down depending on what is closer.
# It must be pointed out that .5 is rounded to the nearest even number (Banker's Rounding)
# ceil(): rounds up to the ceiling
# floor(): rounds down to the floor

price = 35.456789034454
print(round(price))
print(round(price, 2))

# import math
# floor()
print(math.floor(price))

# ceil()
# It can be used in data engineering for resource allocation
print(math.ceil(price))

# math trunc

print(math.trunc(price))


print(int(price))

# When to use int() vs trunc()
# If you are not using math already, just use int(), it is simple and built-in
# If you have already imported math, use trunc(). It makes your intention clearer


# Random
# random()
# print(random.random())
print(random.randint(1, 6))  # In order to generate dummy data

# Validation:
# is_integer(): To check if the value is a whole number
# isinstance(): To check if a value belongs to a particular data type

# is_integer()
x = 7.0
print(x.is_integer())

x = 7.1
print(x.is_integer())

# isinstance()

x = 70
print(isinstance(x, int))

x = 70.8
print(isinstance(x, int))

print('*'*60)
print('''Challenge
Generate a random integer between 1 and 100, 
and check if the result is an even number.''')
print('*'*60)
print('*'*30)
print('Solution')
print('*'*30)
x = random.randint(1, 100)
print(x % 2)          # 0 means even, 1 means odd
print(x % 2 == 0)     # explicit True/False answer to "is it even"
print('*'*30)