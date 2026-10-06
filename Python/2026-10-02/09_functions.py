# =======================================================================
# Functions
# =======================================================================
# What is a function? A small reusable block of code that does one specific job.
# Why Function? * Reusability * Fast Changes * Code Modularity * Collaboration
# Types of function: 1. Built-in function 2. Standard Library
# 3. External Library 4. User Defined Function

def make_coffee():
    print('wake up')
    print('Start Machine')
    print('Make Coffee')
    print('Add milk')
    print('Enjoy it')
    print('Working for a while')

# Defining a function is not enough to execute it, you have to call it
make_coffee()

# Parameters: Data that goes in through an input, Argument, Return: that comes out, return value
# Parameters: Names used in the function definition that describe what data the function expects
# Argument: Actual values passed in a function call, that get assigned to the parameters
# You need two things to build a function: first, define it, second, call it


name = '  MariA   '
print(name.strip().lower())

def clean_name():
    name = '  MariA   '
    print(name.strip().lower())
clean_name()  # Hardcoded value is not reusable because it always cleans the same value

def clean_name(name):  # pass the value as a parameter to handle any input
    cleaned = name.strip().lower()
    print('Raw:', name)
    print('Cleaned:', cleaned)

clean_name(name='  wasiu')  # Value changes but the logic stays the same

# Multiple parameters and Arguments


# default parameters follow non-default parameters
def clean_name(first_name, last_name, country='n/a'):  # pass the value as a parameter to handle any input
    first_name = first_name.strip().lower()
    last_name = last_name.strip().lower()
    full_name = first_name + ' ' + last_name
    print(full_name, 'from', country)

clean_name('MuHaMMAD', 'OPeYEmi', 'Nigeria')  # positional

# In python, we have two ways to send values to a function:
# positional argument (value passed based on its order)
# and keyword argument (value passed based on its name)

# positional Argument
clean_name('MuHaMMAD', 'OPeYEmi', 'Nigeria')
# Keyword Argument
clean_name(first_name='Muhammad', last_name='Akande', country='NG')
# Mixed Argument (positional arguments must come before keyword arguments)
clean_name('Muhammad', last_name='Akande', country='NG')
clean_name('Muhammad', last_name='Akande')


# args and kwargs:
# Allows a function to accept an unknown number of arguments

# Calculate the total values
def total(*args):
    print(sum(args))

total(12, 3, 5, 2, 44, 5, 2, 2, 4, 223, 4, 22)

# When to use *args:
# When you pass similar values
# When to use **kwargs:
# When you pass different named values

# Create the user profile
def create_user(**kwargs):
    print(kwargs)

create_user(
    first_name='Mo',
    last_name='Salah',
    age=33,
    country='Egypt'
)

create_user(first_name='Abdulroqeeb', last_name='Muhammad')

# return
def clean_name(name):  # pass the value as a parameter to handle any input
    cleaned = name.strip().lower()
    # print('Raw:', name)
    return cleaned  # a function can only actually return once per call, this just shows return is reusable across calls
    # print('Cleaned:', cleaned)
cln_name = clean_name(' MarIA     ')
print(cln_name)


def clean_name(name):  # pass the value as a parameter to handle any input
    if not name:
        return None
    else:
        cleaned = name.strip().lower()
        return cleaned
    # print('Cleaned:', cleaned)
cln_name = clean_name(' MarIA     ')
print(cln_name)

# Types of function based on their purpose
# Action Function
# TASK: Stores application log messages in a file whenever an event occurs
def write_log(message):
    with open(r'C:\Users\USER\Desktop\Archive\app.log', 'a') as file:
        file.write(message + '\n')

# Transformation Function
# Clean email addresses and split them into structured data

def clean_and_split_email(email):
    cl_email = email.strip().lower()
    # sara@gmail.com
    username, domain = cl_email.split('@')
    return {'username': username,
            'domain': domain}

print(clean_and_split_email('opeyemi@gmail.com'))

# Validation Function
# TASK: Checks whether the password meets the minimum requirement of 8 characters
def is_valid_password(password):
    return len(password) >= 8

print(is_valid_password('3457890'))

# TASK: Checks whether an email has a basic valid format
def is_valid_email(email):
    return "@" in email and "." in email

print(is_valid_email('sara@gmail.com'))

# Orchestrator Function: A function that controls
# the flow by calling other functions in the correct order

# Project
# Build an application that
# receives an email from the user
# Validates if it is a valid email
# If it is invalid email, logs an error in a file
# If it is valid, cleans and structures the email
# logs each step of the program

# Orchestrator Function, reusing the functions already defined above
# rather than redefining is_valid_email inside it
def process_user_email(email):
    write_log('App Started')
    # Validate if it is a valid email
    if not is_valid_email(email):
        write_log(f'Invalid email received:{email}')
    # If it is valid, clean and structure the email
    else:
        clean_email = clean_and_split_email(email)
        write_log(f'Processed Email: {clean_email}')
    write_log('App stored')

# receive an email from the user
email = input('Please enter your Email: ')
process_user_email(email)