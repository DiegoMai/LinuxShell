#!/bin/bash

# get dirsync home
DIRSYNC_HOME="$(dirname $0)"

# start programm and pass any parameters
java -Xmx512M -jar "$DIRSYNC_HOME/dirsync.jar" $*
