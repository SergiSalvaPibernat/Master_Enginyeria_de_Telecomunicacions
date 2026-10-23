import numpy as np

# Define the number of iterations and the graph type
N_ITERATIONS = 5
DIRECTED_GRAPH = False

# Define the demands and routes
demands = np.array([[8, 8, 5], [4, 6, 2]])
routes = np.array([[1, 5], [5, 1]])

# Define the nodes and links of the substrate
nodes = [1, 2, 3, 4, 5]
links = [(1, 2, 12), (2, 3, 10), (2, 4, 7), (3, 5, 8), (4, 5, 6)]

# Define the structure for the adjacency matrix
adjacency_matrix = np.zeros((len(nodes), len(nodes)))

for link in links:
    src, dst, capacity = link
    adjacency_matrix[src - 1][dst - 1] = capacity
    if not DIRECTED_GRAPH:
        adjacency_matrix[dst - 1][src - 1] = capacity

# Print the adjacency matrix at the beginning
print("Adjacency Matrix (Before Allocations):")
print(adjacency_matrix)

# Calculate the Acceptance Ratio
def calculate_acceptance_ratio(allocation, demand):
    total_capacity = sum(adjacency_matrix[allocation[i] - 1][allocation[i + 1] - 1] for i in range(len(allocation) - 1))
    return min(total_capacity / demand, 1.0)

acceptance_ratios = []
for i in range(len(demands)):
    allocation = routes[i]
    acceptance_ratio = calculate_acceptance_ratio(allocation, demands[i][1])
    acceptance_ratios.append(acceptance_ratio)

# Calculate and print the possibilities for each demand
def find_all_paths(start, end, path=[]):
    path = path + [start]
    if start == end:
        return [path]
    paths = []
    for node in nodes:
        if adjacency_matrix[start - 1][node - 1] > 0 and node not in path:
            new_paths = find_all_paths(node, end, path)
            for new_path in new_paths:
                paths.append(new_path)
    return paths

all_possibilities = []
for i in range(len(demands)):
    possibilities = find_all_paths(routes[i][0], routes[i][1])
    all_possibilities.append(possibilities)

for i, possibilities in enumerate(all_possibilities):
    print(f"Possible allocations for demand {i + 1}:")
    for j, allocation in enumerate(possibilities):
        print(f"Allocation {j + 1}: {allocation}")

# Find the combination of demands with the highest acceptance ratio
max_acceptance_ratio = 0.0
max_allocation = None

for allocation1 in all_possibilities[0]:
    for allocation2 in all_possibilities[1]:
        combined_allocation = allocation1 + allocation2[1:]  # Combine the two allocations
        acceptance_ratio = calculate_acceptance_ratio(combined_allocation, sum(demands[:, 1]))  # Calculate acceptance ratio for combined demand
        if acceptance_ratio > max_acceptance_ratio:
            max_acceptance_ratio = acceptance_ratio
            max_allocation = combined_allocation

# Update the adjacency matrix based on the selected allocation
total_demand = sum(demands[:, 0])
for i in range(len(max_allocation) - 1):
    src, dst = max_allocation[i], max_allocation[i + 1]
    adjacency_matrix[src - 1][dst - 1] -= total_demand
    adjacency_matrix[dst - 1][src - 1] -= total_demand

# Print the selected allocation
print(f"\nSelected allocation with the highest acceptance ratio: {max_allocation}")

# Print the adjacency matrix after allocations
print("\nAdjacency Matrix (After Allocations):")
print(adjacency_matrix)
