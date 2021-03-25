#!/usr/bin/python3

"""
This example shows how to call popen and get the return text.
"""

import sys
import os
import subprocess
p = subprocess.Popen(
    sys.argv[1:],
    shell=False,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE
)

for line in p.stderr:
    line = line.decode().rstrip()
    if line.startswith("*************************"):
        p.kill()
        sys.exit(0)
    # print(f"line is {line}")
