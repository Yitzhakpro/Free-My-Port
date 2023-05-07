#!/bin/bash

read -p "Enter the port you would like to free: " port

tasks_count=$(sudo ss -tlnp | grep -c ":$port ")
echo "Amount of tasks related to that port: $tasks_count"

if [[ $tasks_count == 0 ]]; then
    echo "Port is already free, goodbye :)"
    exit 0
fi

task_lines=$(sudo ss -tlnp | grep ":$port ")
while read -r line; do
    pid=$(echo "$line" | awk '{print $NF}' | cut -d= -f2 | cut -d, -f1)
    echo "Process ID: $pid"

    read -p "Do you want to kill this process? (y/n): " answer </dev/tty
    if [[ $answer == 'y' ]]; then
        kill "$pid"
        echo "Process $pid killed"
    fi
done <<< "$task_lines"