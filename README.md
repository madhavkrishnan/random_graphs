# Random Graphs

The python file ``random_graphs.py`` can generate random Clifford + T circuits using Cirq and saves them as qasm files. Number of qubits, depth and packing
probability can be specified.

The Julia file ``graph_compile.jl`` uses [Jabalizer.jl](https://github.com/QSI-BAQS/Jabalizer.jl/releases/tag/v0.4.4) to compile the algorithm specific graph. 
