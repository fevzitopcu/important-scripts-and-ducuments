#!/bin/bash

# "dynamodb.tf" dosyasındaki modül bloklarını işleme

while IFS= read -r line; do
    if [[ $line == *"module \""* ]]; then
        module_name=$(echo "$line" | awk -F'"' '{print $2}')
    elif [[ $line == *"table_name"* ]]; then
        table_name=$(echo "$line" | awk -F'"' '{print $2}')
        table_name=${table_name,,} # uppercase to lowercase
        sed -i "0,/^module \"$module_name\"/{s/^module \"$module_name\"/module \"dynamodb_$table_name\"/}" dynamodb.tf
    fi
done <"dynamodb.tf"
