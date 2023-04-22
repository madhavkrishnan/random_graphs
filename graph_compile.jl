using Jabalizer
using GraphPlot
using LinearAlgebra
using Graphs
using Printf

silent = true

# Turn this off for larger graphs
plot_graph = false 

# input_file = "TRANSPILED_FH_N2_U2_mu0.0_eps0.01_t1_angles5_recompiled.qasm"
input_file = "FH_N2_U2_mu0.0_recompiled.qasm"

# Load circuit from qasm file. 
println("Loading : ", input_file)
qubits, input_circuit = load_icm_circuit_from_qasm(input_file)


if ! silent
    println("\nInput circuit")
    println("==================")
    display(input_circuit)
    println("Input qubits = ", qubits)
end


println("Starting Graph conversion...")
ts = time()

# Icm decomposition
gates_to_decomp = ["T", "T_Dagger", "RX", "RY", "RZ"];
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

@printf("Graph generation time : %.2f sec", time() - ts)


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
