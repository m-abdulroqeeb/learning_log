# =================================================================
# LOOPS
# =================================================================
print('Round: 1')
print('Round: 2')
print('Round: 3')
print('Round: 4')
print('Round: 5')
print('\n')

# Alternative
for i in (1, 2, 3, 4, 5):
    print('Round:', i)
print('\n')

# For more readability
items = (1, 2, 3, 4, 5)
for i in items:
    print('Round:', i)
print('\n')

# For loops: to use this type of loop, we msut always specify the sequence.
# The sequence can be turple, list, string, range

# sequence: list
items = [1, 2, 3, 4, 5]
for i in items:
    print('Round:', i)
print('\n')

# sequence: string

items = ' Python'
for i in items:
    print('Round:', i)
print('\n')

# sequence: range
for item in range(1, 6):
    print('Round:', item)
print('\n')

# specifying the start and stop for the range
for item in range(1, 6):
    print('Round:', item)
print('\n')

# specifying the step

for item in range(1, 11, 2):
    print('Round:', item)
print('\n')

# Find the summation of the scores
scores = [80, 50, 60, 75]
total = 0
for score in scores:
    total += score
    print('Current Total:', total)
print('Final Total:', total)
print('\n')

# Another example: cleaning
files = [' Report.csv', 'DATA.csv ', 'final.TXT']
# Remove inconsistent cases & unnnecessary spaces
for file in files:
    file = file.strip().lower().replace('.txt','.csv')
    print('processing', file)
print('\n')

# Challenge
#01_Print the 7- times table from 1 to 10 using a for loop

print('Multiplication table 7')
for i in range(1, 11):
    print(f'{7} * {i} =', 7 * i )
print('\n')

# 02_ print a left-aligned pyramid of stars with 6 rows using a for loop
for i in range(1,7):
    print('*' * i)
print('\n')

#Advanced for loops:
# break: immediately exits the loop entirely, skipping any remaining items
names = ['john','maria','','kumar']
for name in names:
    if name == '':
        print('Empty values detected!')
        break
    print(f'Name = {name}')
print('\n')

# continue: skips just the current item and moves to the next one, loop keeps running
for name in names:
    if name == '':
        print('Empty values detected!')
        continue
    print(f'Name = {name}')
    print('\n')

# pass statement: does nothing, just a placeholder so the code doesn't error
# on an empty block, useful when you know you need to handle something later
for name in names:
    if name == '':
        print('Empty values detected!')
        pass #todo: Handle Empty Value
    print(f'Name = {name}')
print('\n')

for name in names:
    if name == '':
        name = name.replace('','unknown')
        #pass (todo: Handle Empty Value)
    print(f'Name = {name}')
print('\n')

# TASK: Loop through a list of days and print only the working days, skipping the weekends
days = ['Mon','Sun','Wed','Tue']
weekends = ['Sat','Sun']
for day in days:
    if day in weekends:
        continue
    print('Workday:', day)
print('\n')

#TASK: Scan emails to block unsafe data from entering your system
emails = [
    'data@gamil.com',
    'op@gmail.com',
    'DROP TABLE USERS;',
    'maria@gmail.com'
]

for email in emails:
    if ';' in email:
        print('SQL Injection: Hacker Attack')
        break
    print('processing Email: ', email)
print('\n')

# for else: the else block only runs if the loop finishes normally, without hitting a break
# if break is triggered, else is skipped entirely, this is what makes it different
# from just writing code after the loop.
# To have a real usage you have to combine the else statement with the break statement
items = [1,2,3,4,7]
for item in items:
    print(item)
else:
    print('The loop is completed')
print('\n')

# find out if there are even number
items = [1,3,7]
for item in items:
    if item % 2 == 0 :
        print('Even number found', item)
        break
else:
    print('All numbers are odd')
