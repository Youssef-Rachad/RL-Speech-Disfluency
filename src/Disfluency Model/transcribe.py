import os
import subprocess

source_directory = "../common_set/"
# output_directory = "transcripts"
command_to_run = "./main -f \"{}\" -ml 1 --output-csv --prompt \"uh uhh um umm so like ah ahh well  \""

# if not os.path.exists(output_directory):
#    os.makedirs(output_directory)

failed_files = []
count = 0
for filename in os.listdir(source_directory):
    source_file_path = os.path.join(source_directory, filename)
    if ('csv' in source_file_path):
        continue
    try:
        os.path.isfile(source_file_path)
        print(f"LOG: Opening {source_file_path}[{count}]")
        count += 1
        # Formulate the output file path in the output directory
        # output_file_path = os.path.join(output_directory, filename + ".output.txt")
        source_file_path = source_file_path.replace('"', '\\"')
        source_file_path = source_file_path.replace("'", "\\'")
        # source_file_path = source_file_path.replace(" ", "\\ ")
        # source_file_path = source_file_path.replace("(", "\\(")
        # source_file_path = source_file_path.replace(")", "\\)")
        # Run the command and pipe the output to the output file
        subprocess.run(command_to_run.format(source_file_path), shell=True)
        '''
        try:
            with open(output_file_path, "w") as output_file:
                #subprocess.run(command_to_run, shell=True, stdout=output_file)
        except Exception as e:
            print(f"ERROR: Command failed to execute or file failed to save\n{e}")
        '''
    except Exception as e:
        print(f"ERROR: Could not open {source_file_path}")
        failed_files.append(source_file_path)

print("COMPLETE\n Failed Files:", failed_files, sep="\n")
