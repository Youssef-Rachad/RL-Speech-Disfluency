import pandas as pd

def tokens_to_txt(input_file, output_file):
    '''
    input_file: must be a csv file with header [start, end, text]
    output_file: can be any file 
    NOTE include fileextension in arg 
    '''
    try:
        df = pd.read_csv(input_file)
        last_column = df.iloc[:, -1]
        
        with open(output_file, 'w') as f:
            f.write("\n".join(last_column.astype(str)))
        
        print(f"LOG Complete {output_file}")

    except Exception as e:
        print("Error: Failed to parse\n", str(e))

convert_time = lambda m: f"{m//(3600000):02d}:{(m//60000)%60:02d}:{(m//1000)%60:02d}:{m%1000:03d}"
