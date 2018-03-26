#!/bin/sh

while true; do free -k | awk -v timestamp=$(date +"%H:%M") 'NR==2{print timestamp,$2,$3,$4}' >> /tmp/memoryusage.dat; sleep 60; done 
