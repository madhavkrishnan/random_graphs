using Jabalizer
using GraphPlot
using LinearAlgebra
using Graphs

silent = false
plot_graph = false

# Load circuit from qasm file. 
qubits, input_circuit = load_icm_circuit_from_qasm("random_circuit_d1000_q100.qasm")



if ! silent
    println("\nInput circuit")
    println("==================")
    display(input_circuit)
    println("Input qubits = ", qubits)
end


# Icm decomposition
gates_to_decomp = ["T", "T^-1"];
icm_circuit, data_qubits = Jabalizer.compile(input_circuit, qubits, gates_to_decomp)
n_qubits = Jabalizer.count_qubits(icm_circuit)

if ! silent
    println("\nICM circuit")
    println("==================")
    display(icm_circuit)
    println("icm_qubits : ", n_qubits)
end

# Initialise a stabilizer state to all 0s
state = zero_state(n_qubits);

# Apply the ICM circuit
Jabalizer.execute_circuit(state, icm_circuit);
graph_state, adj_mat, loc_seq = Jabalizer.to_graph(state);

# Check that the adjaceny matrix is symmetric
issymmetric(adj_mat) || error("Adjacency Matrix is not symmetric.")

# Generate graph
graph = GraphPlot.Graph(adj_mat)

println("\nGraph Nodes : ", Graphs.nv(Graphs.Graph(adj_mat)))
println("Graph Edges : ", Graphs.ne(Graphs.Graph(adj_mat)))

if plot_graph
    # Plot graph (needs backend, works in VSCode)
    layout=(args...)->spring_layout(args...; C=20)
    gplot(graph, layout=layout)
end