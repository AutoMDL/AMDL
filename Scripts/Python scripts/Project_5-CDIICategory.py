import pandas as pd
import os
import sys

def load_existing_file(file_path, columns):
    """Load an existing Excel file or create a new DataFrame with specified columns."""
    if os.path.exists(file_path):
        return pd.read_excel(file_path, engine='openpyxl')
    else:
        return pd.DataFrame(columns=columns)

def check_or_create_files():
    """Ensure all required Excel files exist."""
    file_names = [
        'Structure information.xlsx',
        'Property information.xlsx',
        'Synthesis information.xlsx',
        'Characterization information.xlsx',
        'Calculation information.xlsx',
        'Other information.xlsx'
    ]

    for file_name in file_names:
        if not os.path.exists(file_name):
            pd.DataFrame(columns=['Variable Name', 'Numeric Value', 'Unit', 'Source PDF']).to_excel(file_name, index=False, engine='openpyxl')

def save_real_time(file_map):
    """Save all Excel files in real-time."""
    for file_path, df in file_map.items():
       df.to_excel(file_path, index=False, engine='openpyxl')

def get_processed_values():
    """Retrieve all unique values from the six destination files."""
    file_names = [
        'Structure information.xlsx',
        'Property information.xlsx',
        'Synthesis information.xlsx',
        'Characterization information.xlsx',
        'Calculation information.xlsx',
        'Other information.xlsx'
    ]

    processed_values = set()
    for file_name in file_names:
        if os.path.exists(file_name):
            df = pd.read_excel(file_name, engine='openpyxl')
            if 'Variable Name' in df.columns:
                processed_values.update(df['Variable Name'].dropna().unique())

    return processed_values
def process_excel_file(file_path):
    try:
        # Ensure all required files exist
        check_or_create_files()

        # Initialize dataframes for real-time saving
        file_map = {
            'Structure information.xlsx': load_existing_file('Structure information.xlsx', ['Variable Name', 'Numeric Value', 'Unit', 'Source PDF']),
            'Property information.xlsx': load_existing_file('Property information.xlsx', ['Variable Name', 'Numeric Value', 'Unit', 'Source PDF']),
            'Synthesis information.xlsx': load_existing_file('Synthesis information.xlsx', ['Variable Name', 'Numeric Value', 'Unit', 'Source PDF']),
            'Characterization information.xlsx': load_existing_file('Characterization information.xlsx', ['Variable Name', 'Numeric Value', 'Unit', 'Source PDF']),
            'Calculation information.xlsx': load_existing_file('Calculation information.xlsx', ['Variable Name', 'Numeric Value', 'Unit', 'Source PDF']),
            'Other information.xlsx': load_existing_file('Other information.xlsx', ['Variable Name', 'Numeric Value', 'Unit', 'Source PDF'])
        }

        # Read the input Excel file
        df = pd.read_excel(file_path, engine='openpyxl')

        # Ensure column names are clean and consistent
        df.columns = df.columns.str.strip().str.replace(r'\s+', ' ', regex=True)

        # Verify the required column exists
        if 'Variable Name' not in df.columns:
            raise KeyError("The column 'Variable Name' does not exist in the provided Excel file.")

        unique_values = set(df['Variable Name'].dropna().unique())
        processed_values = get_processed_values()
        remaining_values = unique_values - processed_values

        print(f"{len(remaining_values)} variables left to process.")

        for index, value in enumerate(remaining_values, start=1):
            rows = df[df['Variable Name'] == value].copy()

            if rows.empty:
                print(f"No rows found for Variable Name: {value}. Skipping.")
                continue

            print(f"Number of variables remaining: {len(remaining_values) - index}")
            print("-------------------------------------------------------------------------------------------")
            first_row = rows.iloc[0]
            print(f"Variable Name: {value}\n\nSource PDF: {first_row['File name of the source PDF']}")
            print("-------------------------------------------------------------------------------------------")
            print("Where should the entry go? \n1 - Structure\n2 - Property\n3 - Synthesis\n4 - Characterization\n5 - Calculation\n6 - Other\n")
            print("Waiting for input:")
            while True:
                try:
                    move_input = int(input().strip())
                    if move_input not in range(1, 7):
                        raise ValueError
                    break
                except ValueError:
                    print("Invalid input. Please enter a number between 1 and 6.")

            file_map_keys = {
                1: 'Structure information.xlsx',
                2: 'Property information.xlsx',
                3: 'Synthesis information.xlsx',
                4: 'Characterization information.xlsx',
                5: 'Calculation information.xlsx',
                6: 'Other information.xlsx'
            }

            destination_file = file_map_keys[move_input]
            file_map[destination_file] = pd.concat([file_map[destination_file], rows], ignore_index=True)
            save_real_time(file_map)

            print(f"Entry for '{value}' added to {destination_file}.")

            # Clear the screen
            os.system("cls" if os.name == "nt" else "clear")

        print("Processing complete.")

    except KeyboardInterrupt:
        print("\nInterrupted. Saving progress...")
        save_real_time(file_map)
        print("Progress saved. Exiting.")
        sys.exit()

    except KeyError as key_error:
        print(f"KeyError: {key_error}. Please check the input file.")
        sys.exit()

    except Exception as e:
        print(f"An error occurred: {e}")
        sys.exit()

if __name__ == "__main__":
    # Path to the provided Excel file
    file_path = 'path/to/uncategorized/CD-II'
    os.system("cls" if os.name == "nt" else "clear")
    process_excel_file(file_path)
