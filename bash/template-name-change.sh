#!/bin/bash

# "s3.tf" dosyasındaki modül bloklarını işleme
while IFS= read -r line
do
  if [[ $line == *"module \""* ]]; then
    module_name=$(echo "$line" | awk -F'"' '{print $2}')
  elif [[ $line == *"bucket_name"* ]]; then
    bucket_name=$(echo "$line" | awk -F'"' '{print $2}')
    sed -i "0,/^module \"$module_name\"/{s/^module \"$module_name\"/module \"$bucket_name\"/}" s3.tf
  fi
done < "s3.tf"



<<COMMENTS
# s3.tf dosyasının içindeki modullerin ismini blok içinden bir değiken ile değiştirme için kullanılır.
COMMENTS

# s3.tf dosyasının içindeki modullerin ismini blok içinden bir değiken ile değiştirme için kullanılır.
