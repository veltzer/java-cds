#!/bin/bash
# sudo java -Xshare:dump
OUTPUT=classes.jsa
# OUTPUT=/usr/lib/jvm/java-11-openjdk-amd64/lib/server/classes.jsa
java -Xshare:dump -XX:SharedArchiveFile=${OUTPUT}
ls -l ${OUTPUT}
