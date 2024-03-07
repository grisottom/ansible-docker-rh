import os

SLAVES = os.getenv('SLAVES_HOSTNAMES')
print(SLAVES)

list1 = SLAVES.split(",")

for x in list1:
  print(x)