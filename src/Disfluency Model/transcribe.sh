#!/bin/bash
# Requires ffmpeg downloaded
# arg 1: input directory with all media
# arg 2: output directory 
# Note this script resamples audio to 16kHz
# Note output directory is created if not existant

input_directory="$1"
output_directory="$2"
mkdir -p "$output_directory"

failed_files=()
count=0
echo "LOG Converting (wav) files from $input_directory to $output_directory"
# Loop through all files in the input directory
for file in "$input_directory"/*; do
    file_extension="${file##*.}"
    
    file="${file//\"/\\\"}"

    echo "LOG: Opening $source_file_path  #$count"
    if [[ "$file_extension" =~ ^(wav)$ ]]; then
        filename=$(basename -- "$file")
        filename_no_ext="${filename%.*}"

        ./main -f "$file" -ml 1 --output-csv --prompt "uh uhh um umm so like ah ahh well  "
        
        echo "LOG Converted $filename to WAV format."
    else
        failed_files+=("$filename")
        echo "\033[0;31mERROR\033[0m Could not read $filename."
    fi
    ((count++))
done

mv $input_directory/*.csv $output_directory

echo "LOG Conversion completed."
echo "DEBUG The following files were not converted successfully"
for file in "${failed_files[@]}"; do
    echo "$file"
done


