#!/bin/bash
# Requires ffmpeg downloaded
# arg 1: input directory with all media
# arg 2: output directory 
# Note this script resamples audio to 16kHz
# Note output directory is created if not existant

input_directory="$1"
output_directory="$2"
mkdir -p "$output_directory"

count=0
failed_files=()

echo "LOG Converting (webm, mp3, m4a) files from $input_directory to $output_directory"
# Loop through all files in the input directory
for file in "$input_directory"/*; do
    file_extension="${file##*.}"
    
    if [[ "$file_extension" =~ ^(webm|mp3|m4a)$ ]]; then
        filename=$(basename -- "$file")
        filename_no_ext="${filename%.*}"
        
        ffmpeg -i "$file" -ar 16000 "$output_directory/$filename_no_ext.wav"
        
        echo "LOG Converted $filename to WAV format."
    else
        failed_files+=("$filename")
        echo "\033[0;31mERROR\033[0m Skipping $filename [$count]. Unsupported format."
    fi
    ((count++))
done

echo "LOG Conversion completed. $count files"
echo "DEBUG The following files were not converted successfully"
for file in "${failed_files[@]}"; do
    echo "$file"
done

