#!/bin/bash

for major in {556..566}; do
    for minor in {00..99}; do
        for platform in {"desktop","notebook"}; do
            for version in {"nsd-",""}; do
            download_string="https://us.download.nvidia.com/Windows/${major}.${minor}/${major}.${minor}-${platform}-win10-win11-64bit-international-${version}dch-whql.exe"
            
            response=$(curl -s -o /dev/null  -I -w "%{http_code}" "$download_string")
            if [[ "$response" -ne 200 ]]; then
                echo "Failed to download: ${download_string}"
                continue
            elif [[ "$response" -eq 200 ]];then
                echo "Downloading: ${download_string}"
                mkdir -p drivers/${major}.${minor}/${platform}
                curl -o drivers/${major}.${minor}/${platform}/$(basename ${download_string}) ${download_string} &
            fi
            done
        done
    done
done