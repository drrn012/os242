#!/bin/bash

# Extract 10-digit student IDs (NPMs) from inputSCRAP.txt
# Sort them and remove duplicates
grep -oE '[0-9]{10}' inputSCRAP.txt | sort | uniq > outputSCRAP.txt
