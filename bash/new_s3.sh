#!/bin/bash

# "s3.tf" dosyasındaki modül bloklarını işleme
while IFS= read -r line
do
  if [[ $line == *"module \""* ]]; then
    module_name=$(echo "$line" | awk -F'"' '{print $2}')
  elif [[ $line == *"bucket_name"* ]]; then
    bucket_name=$(echo "$line" | awk -F'"' '{print $2}')
    new_bucket_name="${bucket_name//-/_}"  # "-" karakterlerini "_" ile değiştir
    #last_bucket_name="${new_bucket_name//./_}"  # "." karakterlerini "_" ile değiştir
    sed -i "0,/^module \"$module_name\"/{s/^module \"$module_name\"/module \"s3_$new_bucket_name\"/}" s3.tf
  fi
done < "s3.tf"