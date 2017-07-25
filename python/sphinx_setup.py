#! /user/bin/env python
"""

A script to set up Sphinx documentation environment

"""
import sys
import subprocess
# import re


def usage():
    "a help function for this script"
    print(__doc__)


def argv_contains(*args):
    "rapid truthy/falsy test of whether args are in sys.argv"
    return [i for i in args if i in sys.argv]


if __name__ == '__main__':
    if len(sys.argv) == 1 and sys.argv[0] == '':
        usage()
    elif argv_contains('-h', '--help'):
        usage()
    else:
        if argv_contains('-q', '--quickstart'):
            subprocess.call('sphinx-quickstart')
        if argv_contains('-r', '--with-rst'):
            print('add_rst')
