import json
import matplotlib.pyplot as plt
import pandas as pd

# Read the input JSON file
with open('input.json', 'r') as f:
    data = json.load(f)

# Convert JSON data into a DataFrame
df = pd.DataFrame(data)

# Check if required columns exist
if not all(col in df.columns for col in ['user_id', 'timestamp', 'responses']):
    raise ValueError("Input JSON must contain 'user_id', 'timestamp', and 'responses' columns.")

# Ensure 'responses' column contains dictionaries/lists of numeric values
if not all(isinstance(resp, (dict, list)) for resp in df['responses']):
    raise ValueError("The 'responses' column must contain dictionaries or lists of numeric values.")

# Increment numeric responses by 1
def increment_responses(responses):
    if isinstance(responses, dict):
        return {k: v + 1 if isinstance(v, (int, float)) else v for k, v in responses.items()}
    elif isinstance(responses, list):
        return [v + 1 if isinstance(v, (int, float)) else v for v in responses]
    else:
        return responses

df['responses'] = df['responses'].apply(increment_responses)

# Calculate the sum of all responses
# Assuming the responses are numeric and can be summed
def sum_responses(responses):
    if isinstance(responses, dict):
        return sum(v for v in responses.values() if isinstance(v, (int, float)))
    elif isinstance(responses, list):
        return sum(v for v in responses if isinstance(v, (int, float)))
    else:
        return 0

df['sum_responses'] = df['responses'].apply(sum_responses)

# Calculate the total sum across all users
total_sum = df['sum_responses'].sum()

# Generate a bar plot of the summed responses
plt.figure(figsize=(10, 6))
plt.bar(df['user_id'], df['sum_responses'], color='skyblue')
plt.title('Sum of Responses per User')
plt.xlabel('User ID')
plt.ylabel('Sum of Responses')
plt.xticks(rotation=45, ha='right')
plt.tight_layout()
plt.savefig('responses_plot.png')
plt.close()

# Export the results to a new JSON file
output_data = {
    'total_sum': total_sum,
    'user_sums': df[['user_id', 'sum_responses']].to_dict(orient='records')
}

with open('output.json', 'w') as f:
    json.dump(output_data, f, indent=4)

print("Processing complete. Results saved to 'output.json' and plot saved to 'responses_plot.png'.")
