#!/bin/bash

df | grep /dev/ | grep -v tmpfs | awk '{t += $2}; {u += $3}; END{print u/t}'
