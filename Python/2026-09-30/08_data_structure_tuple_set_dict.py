# =================================================================
# Data Structures(Tuple,Set,Dict)
# =================================================================
# What is a tuple? An ordered collection that can't be changed after creation
# In python, each data structure has its own personality, which could be:
# Order:
#   - Tuple retains the order of your values
# Duplicate:
#   - Tuple allows duplicates
# Indexed:
#   - Tuple values can be indexed
# Mutable:
#   - Unlike list, tuple values are immutable


# Tuple
my_tuple = (10, 30, 20)
print(my_tuple)  # ordered

my_tuple = (10, 30, 20, 10)
print(my_tuple)  # Like the list, it allows duplicates

my_tuple = (10, 30, 20)
print(my_tuple[1])  # Like the list, it can be indexed
# my_tuple[3] = 40 #It is immutable

print(sorted(my_tuple, reverse=True))
# sorted() returns a plain list, not a tuple
# this proves nothing about the tuple itself changes, since the output type is different

# Set
# What is a set? Unordered collection of unique values {}

my_set = {10, 30, 20}
print(my_set)  # It is unordered, it does not retain the order values were added in

my_set = {10, 30, 20, 10}
print(my_set)  # It doesn't take duplicates


my_set = {10, 30, 20, 10}
# print(my_set[1]) #Not indexed

my_set = {10, 30, 20, 10}
my_set.remove(10)
my_set.add(23)  # It is mutable
print(my_set)

# Set Methods
# Note: index-based methods do not work with sets
# Note: You can use math operators as quick shortcuts: |&-^
a = {10, 20, 30, 40}
a.add(50)  # inserts the item into the set, but only if it is new
a.update([40])  # Merges another group of values (iterable) into the set
a |= {1, 2}  # works like update()
# a.remove(100) #Throws an error if the value is missing...Alternative is discard
a.discard(10)  # Removes the item if it exists, does nothing if it does not
print(a)

# Mathematical Operations
# Math operators return a new set and leave the originals untouched
a = {10, 20, 30, 40}
b = {30, 40, 50, 60}
print(a.union(b))  # To join two sets together without duplicates
# Alternative
print(a | b)

# intersection: Returns only the shared items
print(a.intersection(b))
# alternative
print(a & b)

# difference: Returns items in A, but not in B
print(a.difference(b))
print(a - b)
# Returns items in B, but not in A
print(b.difference(a))
# Alternative
print(b - a)

# Find the values that are not shared by both sets
print(a.symmetric_difference(b))

a = {10, 20, 30, 40}
b = {50, 20, 40, 10, 60, 30}

# Is everything in A also in B
print(a.issubset(b))  # returns true if all items in this set exist in the other

# Does set B contain every single item in set A
# issuperset is directional, so these two checks are not interchangeable
print(b.issuperset(a))  # returns true when B includes ALL items of A
print(a.issuperset(b))  # returns False here, since A doesn't contain everything in B

# isdisjoint: Returns true if both sets share no item (no overlap at all)
print(a.isdisjoint(b))

# DICT
# Dict: It allows you to store different types of information in key value pairs,
# where the key describes what the data means.

my_dict = {
    'a': 10,
    'b': 20,
    'c': 30,
    'd': 10
}
print(my_dict)  # Dict is ordered because it retains the order you define your pairs in
# 'a':40 : it does not allow duplicates in the keys, meaning the keys must be unique
# Although values allow duplicates

# print(my_dict[1]) # It is not indexed...Although we can still access values by specifying the keys
print(my_dict['d'])

my_dict['c'] = 20
print(my_dict)  # Dict is mutable

# Dict Special Methods
user = {'id': 1, 'age': 30, 'city': 'Lagos'}

# Access
print(user['age'])
# print(user['nm'])....Python throws a KeyError because the key is not found

# Alternative
print(user.get('city', 'Unknown'))
# get(): returns the value safely, gives the provided default (or None) if missing

# Checks
print('age' in user)
print('height' in user)

# View Object
print(user.keys())  # Returns all the keys of your dictionary
print(user.values())  # Returns only the values
print(user.items())  # Returns all key-value pairs of your dictionary
print(user)

# Looping
for u in user:
    print(u, user[u])  # Older method, loops over keys and manually looks up each value


for key, value in user.items():
    print(key, value)


user = {'id': 1, 'age': 30, 'city': 'Lagos'}
# Add, Remove, Update
user['name'] = 'John'  # add
user['age'] = 35  # update
user.update({'age': 40, 'city': 'Ikeja'})  # Adds new keys and updates existing ones using another dictionary
print(user)
# Assigning a key: Updates the value if the key exists,
# or inserts a new key value pair if it doesn't

age = user.pop('age', 'Not Found')  # Remove, the second argument is a fallback default
print(age)
print(user)

# To remove the last item without specifying it
# popitem(): returns and deletes the most recently added key value pair from the dictionary

user.popitem()
print(user)

# Creation
user = {
    'id': None,
    'name': None,
    'age': None,
    'city': None
}
print(user)

user = dict.fromkeys(['id', 'name', 'age', 'city'], 'Unknown')
# Builds a new dictionary where every key gets
# the same default value
print(user)

# dict real world application
# 1_use case: Database or API Records - Returned records are stored as dictionaries
# where column names are keys and the row values are the dictionary values
# 2_use_case: Mapping to friendly values -
# Great for converting technical codes into friendly labels. Example below:
status_map = {
    '01': 'Open',
    '02': 'In progress',
    '03': 'Done'
}

# 3_use case: mapping abbreviations: Turning short abbreviations into full readable names.
# 4_use case: config and environment data - Store system settings like
# host, port, and usernames in one clean place
# 5_use case: ETL and pipeline settings - Great for storing run parameters
# and controlling how your etl pipeline loads data
# 6_Use case: Metadata (data about data)

# Challenge
user = {'id': 1, 'name': 'john', 'age': 30, 'city': 'Berlin'}
# 1. Create a new dict
# 2. Keep only pairs with string values
# 3. Convert values to uppercase
# 4. Elegant and short solution

print('\nSolution\n')

user_str = {
    k: v.upper()
    for k, v in user.items()
    if isinstance(v, str)  # filter
}

print(user_str)