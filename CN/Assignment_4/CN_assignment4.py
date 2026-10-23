import numpy as np  # Importing the NumPy library and assigning it the alias 'np'
import networkx as nx  # Importing the NetworkX library and assigning it the alias 'nx'
import copy  # Importing the copy module
import scipy as sp  # Importing the SciPy library and assigning it the alias 'sp'

N_ITERATIONS = 10  # Setting the value of the variable 'N_ITERATIONS' to 10
DIRECTED_GRAPH = False  # Setting the value of the variable 'DIRECTED_GRAPH' to False

demands = np.array([[15, 8, 5], [4, 6, 2]])  # Creating a NumPy array 'demands' with shape (2, 3)
routes = np.array([[1, 5], [5, 1]])  # Creating a NumPy array 'routes' with shape (2, 2)

nodes = [1, 2, 3, 4, 5]  # Creating a list 'nodes' with five elements
links = [(1, 2, 12), (2, 3, 10), (2, 4, 7), (3, 5, 8), (4, 5, 6)]  # Creating a list 'links' with five tuples

def path_weights(W, path):  # Defining a function 'path_weights' that takes two arguments: 'W' and 'path'
    weights = []  # Creating an empty list 'weights'
    for i in range(len(path) - 1):  # Looping over the range from 0 to len(path) - 2
        weights.append(W[path[i]][path[i + 1]]["weight"])  # Appending the weight value from the graph to the 'weights' list
    return weights  # Returning the 'weights' list

def find_better_fitted_path(W, demand, paths):  # Defining a function 'find_better_fitted_path' that takes three arguments: 'W', 'demand', and 'paths'
    fitness = []  # Creating an empty list 'fitness'
    for path in paths:  # Looping over the 'paths' iterable
        pw = path_weights(W, path)  # Calling the 'path_weights' function to calculate the weights of the 'path'
        difference = np.array(pw) - np.array(demand)  # Calculating the element-wise difference between 'pw' and 'demand' arrays
        if not np.any(difference < 0):  # Checking if there are no negative values in the 'difference' array
            fitness.append(np.sum(difference))  # Appending the sum of 'difference' array to 'fitness' list
        else:
            fitness.append(999999)  # Appending a large value (999999) to 'fitness' list
    if np.any(np.array(fitness) != 999999):  # Checking if there exists a value other than 999999 in the 'fitness' array
        return np.argmin(fitness)  # Returning the index of the minimum value in the 'fitness' array
    else:
        return -1  # Returning -1 if all fitness values are 999999

def allocate_demand(graph, origin, destination, demand):  # Defining a function 'allocate_demand' that takes four arguments: 'graph', 'origin', 'destination', and 'demand'
    paths = nx.all_simple_paths(graph, origin, destination)  # Generating all simple paths between 'origin' and 'destination' in the 'graph'
    paths = list(paths)  # Converting the 'paths' generator to a list
    print("Demand:", demand, "Possible paths:", paths) # Prints all the possible path for each demand
    fittest_path = find_better_fitted_path(graph, demand, paths)  # Finding the best fitted path for the 'demand' using 'find_better_fitted_path' function
    if fittest_path == -1:  # Checking if no fittest path was found
        return -1  # Returning -1
    path = paths[fittest_path]  # Selecting the fittest path from the 'paths' list
    for i in range(len(path) - 1):  # Looping over the range from 0 to len(path) - 2
        new_capacity = graph[path[i]][path[i + 1]]['weight'] - demand[i]  # Calculating the new capacity of the link
        graph[path[i]][path[i + 1]]['weight'] = new_capacity  # Updating the capacity of the link in the 'graph'
    return [graph, path]  # Returning a list containing the 'graph' and 'path'

optimal_solution = False  # Setting the value of the variable 'optimal_solution' to False

if DIRECTED_GRAPH:  # Checking the value of 'DIRECTED_GRAPH'
    W = nx.DiGraph()  # Creating a directed graph object and assigning it to 'W'
else:
    W = nx.Graph()  # Creating an undirected graph object and assigning it to 'W'
W.add_nodes_from(nodes)  # Adding nodes to the graph 'W'
W.add_weighted_edges_from(links, weight='weight')  # Adding weighted edges to the graph 'W'

print("* Original adjacency matrix:")  # Printing a message indicating the original adjacency matrix
adj_matrix = nx.adjacency_matrix(W).toarray()  # Calculating the adjacency matrix of the graph 'W' and converting it to a NumPy array
print(adj_matrix)  # Printing the adjacency matrix
print("***********")  # Printing a separator line

acceptance_ratio_record = []  # Creating an empty list 'acceptance_ratio_record'
demands_record = []  # Creating an empty list 'demands_record'
routes_record = []  # Creating an empty list 'routes_record'

acceptance_ratio = 0  # Initializing the variable 'acceptance_ratio' with 0

for i in range(N_ITERATIONS):  # Looping from 0 to N_ITERATIONS - 1
    allocated = 0  # Initializing the variable 'allocated' with 0
    W_buff = copy.deepcopy(W)  # Creating a deep copy of the graph 'W' and assigning it to 'W_buff'
    demand_allocation = []  # Creating an empty list 'demand_allocation'
    for d in range(len(demands)):  # Looping over the range from 0 to the length of 'demands' array - 1
        origin = routes[d][0]  # Assigning the value of the first element in 'routes[d]' to 'origin'
        destination = routes[d][1]  # Assigning the value of the second element in 'routes[d]' to 'destination'
        out = allocate_demand(W_buff, origin, destination, demands[d])  # Allocating the demand using 'allocate_demand' function
        if out == -1:  # Checking if demand allocation was unsuccessful
            demand_allocation.append([demands[d], -1])  # Appending the demand and -1 to 'demand_allocation' list
        else:
            demand_allocation.append([demands[d], out[1]])  # Appending the demand and allocated path to 'demand_allocation' list
            W_buff = out[0]  # Updating 'W_buff' with the allocated graph
            allocated += 1  # Incrementing the 'allocated' variable
    acceptance_ratio = allocated / len(demands)  # Calculating the acceptance ratio
    acceptance_ratio_record.append(acceptance_ratio)  # Appending the acceptance ratio to 'acceptance_ratio_record' list
    demands_record.append(copy.deepcopy(demands))  # Appending a deep copy of 'demands' array to 'demands_record' list
    routes_record.append(copy.deepcopy(routes))  # Appending a deep copy of 'routes' array to 'routes_record' list
    shuffler = np.random.permutation(len(demands))  # Creating a random permutation of indices for 'demands' array
    demands = demands[shuffler]  # Reordering 'demands' array using the shuffled indices
    routes = routes[shuffler]  # Reordering 'routes' array using the shuffled indices
    if acceptance_ratio == 1:  # Checking if the acceptance ratio is 1 (optimal solution found)
        optimal_solution = True  # Setting 'optimal_solution' to True
        break  # Exiting the loop

if not optimal_solution:  # Checking if optimal solution was not found
    best = np.argmax(acceptance_ratio_record)  # Finding the index of the highest acceptance ratio
    demands = demands_record[best]  # Updating 'demands' with the demands from the best iteration
    routes = routes_record[best]  # Updating 'routes' with the routes from the best iteration
    W_buff = copy.deepcopy(W)  # Creating a deep copy of the graph 'W' and assigning it to 'W_buff'
    demand_allocation = []  # Creating an empty list 'demand_allocation'
    for d in range(len(demands)):  # Looping over the range from 0 to the length of 'demands' array - 1
        origin = routes[d][0]  # Assigning the value of the first element in 'routes[d]' to 'origin'
        destination = routes[d][1]  # Assigning the value of the second element in 'routes[d]' to 'destination'
        out = allocate_demand(W_buff, origin, destination, demands[d])  # Allocating the demand using 'allocate_demand' function
        if out == -1:  # Checking if demand allocation was unsuccessful
            demand_allocation.append([demands[d], -1])  # Appending the demand and -1 to 'demand_allocation' list
        else:
            demand_allocation.append([demands[d], out[1]])  # Appending the demand and allocated path to 'demand_allocation' list
            W_buff = out[0]  # Updating 'W_buff' with the allocated graph

print("***********")  # Printing a separator line
print("* SUCCESSFULLY ALLOCATED DEMANDS:")  # Printing a message indicating the successful demand allocations
for i in range(len(demand_allocation)):  # Looping over the range from 0 to the length of 'demand_allocation' list - 1
    if demand_allocation[i][1] != -1:  # Checking if the allocated path is not -1 (demand was successfully allocated)
        print("Demand:", demand_allocation[i][0], "Origin/Destination:", routes[i], "Selected path:", demand_allocation[i][1])  # Printing the demand, origin/destination, and selected path
print("***********")  # Printing a separator line

print("* DEMANDS THAT COULDN'T BE ALLOCATED:")  # Printing a message indicating the demands that couldn't be allocated
for i in range(len(demand_allocation)):  # Looping over the range from 0 to the length of 'demand_allocation' list - 1
    if demand_allocation[i][1] == -1:  # Checking if the allocated path is -1 (demand couldn't be allocated)
        print("Demand:", demand_allocation[i][0], "Origin/Destination:", routes[i])  # Printing the demand and origin/destination
print("***********")  # Printing a separator line

print("* Final adjacency matrix:")  # Printing a message indicating the final adjacency matrix
adj_matrix = nx.adjacency_matrix(W_buff).toarray()  # Calculating the adjacency matrix of the allocated graph and converting it to a NumPy array
print(adj_matrix)  # Printing the adjacency matrix