#!/bin/bash
echo $(free | grep Mem | awk '{print $3/$2}')
