import json
from mp_api.client import MPRester

# Replace 'YOUR_API_KEY' with your actual Materials Project API key
API_KEY = 'your-api-key'

def retrieve_materials():
    # Initialize the MPRester with your API key
    with MPRester(API_KEY) as mpr:
        # Define the elements to include (Li, O, and any other metal elements)
        elements = ["Li", "O", "Al", "Fe", "Cu", "Ni", "Co", "Mg", "Mn", "Ti", "Zn"]
        # Define the filter for metals (excluding non-metal elements)
        metal_elements = [el for el in elements if el not in ["H", "B", "C", "N", "O", "F", "P", "S", "Se", "Cl", "Br", "I", "He", "Ne", "Ar", "Kr", "Xe", "Rn"]]
        
        # Retrieve materials containing Li, O, and at least one metal element
        #query = {
          #  "elements": {"$in": elements},
           # "nelements": {"$gte": 3},  # At least 3 elements (Li, O, and a metal)
       # }
        
        materials = mpr.materials.search(elements=["Li","O"], 
                                       exclude_elements=["H", "B", "C", "N", "F", "P", "S", "Se", "Cl", "Br", "I", "He", "Ne", "Ar", "Kr", "Xe", "Rn","Si"]
                                       )

         # Filter results to include only materials with at least one metal
        filtered_results = []
        for material in materials:
            composition = material.structure.formula  # Use composition attribute
            if any(metal in composition for metal in metal_elements):
                filtered_results.append({
                    "mp-id": material.material_id,  # Access material_id attribute
                    "composition": composition,
                    "c-axis length": material.structure.lattice.abc[2]  # Safely access c-axis length
                })
        
        # Write the results to a JSON file
        with open("materials_info.json", "w") as json_file:
            json.dump(filtered_results, json_file, indent=4)

if __name__ == "__main__":
    retrieve_materials()




