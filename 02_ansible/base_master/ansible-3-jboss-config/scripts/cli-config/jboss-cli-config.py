import os

SLAVES = os.getenv('SLAVES_HOSTNAMES')
print(SLAVES)

for x in SLAVES:
  print(x)