# ===================================================================
#  Conditional Statemenmt
# ===================================================================
# Conditional Statemenmt: It is like a check point in your code that is going to check a condition.
# If the condition is true, it is going to run the special sets of code.
# If it is false, it is going to skip it.

# Identation: Adding spaces at the beginning of a line to show that the line belongs
# to a code block

score = 20
submitted_project = False
if score >= 90:
    if submitted_project: #Nested if
        print('A+')
        print('Great Job!')
    else:
        print('A')
elif score >= 80:
    print('B')
elif score >= 70:
    print('C')
else:
    print('F')

score = 20
submitted_project = False
if score >= 90 and submitted_project:
    print('A+')
    print('Great Job!')
elif score >= 90:
        print('A')
elif score >= 80:
    print('B')
elif score >= 70:
    print('C')
else:
    print('F')

# Independent if
score = 50
submitted_project = False

if score >= 90:
    print('High Score')
else:
    print('Low Score')

if submitted_project:
    print('Project is Submitted')
else :
    print('Project is not submitted')

# Inline If(Ternary)
score = 12
grade = 'A' if score >= 90 else 'F' #only 'if' and 'else' can be used.
print(grade)

grade = ('A' if score >= 90 
         else 'B' if score >= 80 
         else 'F')
print(grade)

# Case - match : Evaluate a value against multiple values. Runs the code of th first match
# TASK: Conver the full country names into 2- letter abbrevaitions

country = 'Egypt'
if country == 'United States':
    print('US')
elif country == 'India':
    print('IN')
elif country == 'Egypt':
    print('EG')
else:
    print('Unknown Country')


match country:
    case 'United States' | 'USA':
        print('US')
    case 'India':
        print('IN')
    case 'Egypt':
        print('EG')
    case 'Germany':
        print('DE')
    case _:
        print('Unknown Country')


# Validate the quality and correctness of email values
# Must not be empty
# Must contain '.' and '@'
# Must contain exactly one '@' symbol
# Must end with '.com','.org', or '.net'
# Must not be longer than 254 characters
# Must start or end with a letter or digit

email = 'opyemig@mail.com'

email = email.strip()
# Email must not be empty
if email == '':
    print('email cannot be empty')
# Email must contain '.' and '@'
elif not ('.' in email and '@' in email):
    print('Email must contain . and @')
# Email must contain exactly one '@' symbol
elif not (email.count('@') == 1):
    print('email must contain one @')
# email must end with '.com','.org', or '.net'
elif  not (email.endswith(('.com','.org,''.net'))):
    print('email must end with .com,.org, or .net')
# Email must not be longer than 254 characters
elif not(len(email) <= 254):
    print('Email must not be longer than 254 characters')
# Email must start or end with a letter or digit
elif not (email[0].isalnum() or email[-1].isalnum()):
    print('Email must start or end with a letter or digit')
else:
    print('email is valid.')

# independent if
email = '.opyemig@mail.co/'
email = email.strip()
# Email must not be empty
if email == '':
    print('email cannot be empty')
# Email must contain '.' and '@'
if not ('.' in email and '@' in email):
    print('Email must contain . and @')
# Email must contain exactly one '@' symbol
if not (email.count('@') == 1):
    print('email must contain one @')
# email must end with '.com','.org', or '.net'
if  not (email.endswith(('.com','.org,''.net'))):
    print('email must end with .com,.org, or .net')
# Email must not be longer than 254 characters
if not(len(email) <= 254):
    print('Email must not be longer than 254 characters')
# Email must start or end with a letter or digit
if not (email[0].isalnum() or email[-1].isalnum()):
    print('Email must start or end with a letter or digit')
else:
    print('email is valid.')

# Challenge
# Validate the quality and correctness of passwords
# Must not be empty
# Must be atleast 8 characters long
# Must include at least 1 uppercase
# Must include at least 1 lowercase
# Must not be same as the email
# Must not contain any spaces
# Must contail only letter or digit

email = 'mypasSword'
password = 'mypas Sword' 
# Clean the password
password = password.strip()
# password must not be empty
if password == '':
    print('password must not be empty')
# password must be atleast 8 characters long
elif not(len(password) >= 8):
    print('password must be atleast 8 characters long')
# password must include at least 1 uppercase
elif not any(c.isupper() for c in password):
    print('password must include at least 1 uppercase')
# password must include at least 1 lowercase
elif not any(u.islower() for u in password):
    print('password must include at least 1 lowercase')
# password must not be same as the email
elif password == email:
    print('password must not be the same as the email')
# password must not contain any spaces
elif ' ' in password:
    print('password must not contain any spaces')
#Password must contail only letter or digit
elif not(password.isalnum()):
    print('Password must contail only letter or digit')





