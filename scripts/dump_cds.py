#!/usr/bin/env python

""" Generate the JVM class-data-sharing archive, reproducing the Makefile's
default `dump` target: java -Xshare:dump -XX:SharedArchiveFile=classes.jsa
sample.jar. File arguments are ignored; the jar and archive names are fixed. """

import subprocess
import sys

JSA = "classes.jsa"
JAR = "sample.jar"


def main():
    """ main entry point """
    sys.exit(subprocess.call(
        ["java", "-Xshare:dump", "-XX:SharedArchiveFile=" + JSA, JAR]))


if __name__ == "__main__":
    main()
