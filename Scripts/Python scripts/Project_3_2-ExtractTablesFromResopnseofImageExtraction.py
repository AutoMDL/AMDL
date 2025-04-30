import json
import pandas as pd
import os

def extract_markdown_tables(response):
    """Extract markdown tables enclosed in triple backticks from the response."""
    if '```' in response:
        # Extract content between triple backticks
        tables = response.split('```')[1]
        return tables.strip().split('\n')
    elif 'information:'in response:
        tables = response.split('information:')[1]
        return tables.strip().split('\n')
    return []

def process_markdown_table(data, paper_name):
    header = data[0].strip('|').split('|')
    rows = [row.strip('|').split('|') for row in data[1:]]

    header = [col.strip() for col in header]
    cleaned_rows = [[element.strip() for element in row] for row in rows]

    selected_columns = ["MXene Name", "Variable Name", "Numeric Value", "Unit"]
    try:
        selected_indices = [header.index(col) for col in selected_columns if col in header]
    except ValueError as e:
        print(f"Error: A column name was not found in the header. {str(e)}")
        return pd.DataFrame()  # Return an empty DataFrame on error

    filtered_rows = []
    for row in cleaned_rows:
        if len(row) >= max(selected_indices, default=-1) + 1:
            try:
                filtered_row = [row[i] for i in selected_indices]
                filtered_rows.append(filtered_row)
            except IndexError as e:
                print(f"Error processing row {row}: {str(e)}")
                continue  # Skip rows that cause index errors
        else:
            print(f"Skipping incomplete row {row}")
            continue  # Skip incomplete rows

    df = pd.DataFrame(filtered_rows, columns=selected_columns)
    df['File name of the source PDF'] = paper_name
    return df

def extract_and_clean_tables(file_path):
    """Extract and clean tables from JSON file, handling multiple JSON objects per file."""
    tables = []
    with open(file_path, 'r') as file:
        lines = file.readlines()  # Read the file as a list of lines
        for line in lines:
            try:
                entry = json.loads(line)  # Try to parse each line as a JSON object
                if 'Response' in entry:
                    markdown_data = extract_markdown_tables(entry['Response'])
                    if markdown_data:
                        df = process_markdown_table(markdown_data, entry['PaperName'])
                        tables.append(df)
            except json.JSONDecodeError as e:
                print(f"Error decoding JSON on line: {line} - {str(e)}")
    return tables

def process_json_files(directory):
    """Process all JSON files in the specified directory."""
    all_tables = []
    for filename in os.listdir(directory):
        if filename.endswith(".json"):
            file_path = os.path.join(directory, filename)
            tables = extract_and_clean_tables(file_path)
            all_tables.extend(tables)
    return all_tables

# Define the path to the directory containing JSON files
json_directory = "./MXene-SourceJSON-Springer"
output_directory = "./MXene-Results"

# Process all JSON files
all_tables = process_json_files(json_directory)
combined_table = pd.concat(all_tables, ignore_index=True)

# Define the columns to include in the Excel output
standard_columns = ["MXene Name", "Variable Name", "Numeric Value", "Unit", "File name of the source PDF"]
combined_table = combined_table[standard_columns]

# Save the combined table to an Excel file
output_file_path = os.path.join(output_directory, "output_Springer.xlsx")
combined_table.to_excel(output_file_path, index=False)

print(f"Tables have been successfully extracted and saved to {output_file_path}.")
