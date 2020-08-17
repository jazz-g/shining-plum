#!/bin/bash

echo $(grep 'cpu ' /proc/stat | awk '{usage=(($2+$4)*100/($2+$4+$5))/100} END {print usage}')
