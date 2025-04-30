import pandas as pd
import json

def load_json(file_path):
    """Load JSON data from a file."""
    with open(file_path, 'r') as file:
        return json.load(file)

def organize_data(json_data):
    """Organize data from JSON to desired structure."""
    organized_data = []

    for item in json_data:
        mp_id = item.get("mp-id")
        c_axis_length = item.get("c-axis length")
        composition = item.get("composition", "")
        parts = composition.split()

        # Initialize element and number lists with Li and O fixed
        elements = ["Li", "O", "Ni", "Co", "Mn", "-","-","-","-","-"]
        numbers = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

        # Sort elements and numbers to ensure "Li" is in E1, "O" is in E2, "Ni" is in E3, "Co" is in E4 and "Mn" is in E5
        for part in parts:
            elem = ''.join(filter(str.isalpha, part))
            num = int(''.join(filter(str.isdigit, part)))

            if elem == "Li":
                elements[0], numbers[0] = elem, num
            elif elem == "O":
                elements[1], numbers[1] = elem, num
            elif elem == "Ni":
                elements[2], numbers[2] = elem, num
            elif elem == "Co":
                elements[3], numbers[3] = elem, num
            elif elem == "Mn":
                elements[4], numbers[4] = elem, num
            else:
                for i in range(5, 10):
                    if elements[i] == "-":
                        elements[i], numbers[i] = elem, num
                        break

        # Prepare the row
        row = [mp_id, c_axis_length] + [elem for pair in zip(elements, numbers) for elem in pair]
        organized_data.append(row)
    
    return organized_data

def save_to_excel(data, output_file):
    """Save organized data to an Excel file."""
    columns = ["MP ID", "c-axis length", "E1", "n1", "E2", "n2", "E3", "n3", "E4", "n4", "E5", "n5", "E6", "n6","E7","n7","E8","n8","E9","n9","E10","n10"]
    df = pd.DataFrame(data, columns=columns)
    df.to_excel(output_file, index=False)

def main(json_file, output_excel):
    json_data = load_json(json_file)
    organized_data = organize_data(json_data)
    save_to_excel(organized_data, output_excel)

if __name__ == "__main__":
    # Example usage
    json_file_path = './materials_info.json'  # Change to your JSON file path
    output_excel_path = './output2.xlsx'  # Change to your desired output Excel file path
    main(json_file_path, output_excel_path)
