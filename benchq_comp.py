from qiskit.circuit import QuantumCircuit 
from benchq.compilation import get_algorithmic_graph_from_Jabalizer, pyliqtr_transpile_to_clifford_t
import time

# input_file = "TRANSPILED_FH_N2_U2_mu0.0_eps0.01_t1_angles5_recompiled.qasm"
input_file = "FH_N2_U2_mu0.0_recompiled.qasm"

print("Loading file : ", input_file)
demo_circuit = QuantumCircuit.from_qasm_file(input_file)

cliff_t = pyliqtr_transpile_to_clifford_t(demo_circuit)

ts = time.time()
print("Starting graph conversion...")
get_algorithmic_graph_from_Jabalizer(cliff_t)

print(f"Graph generation time : {time.time()-ts :.2f} sec",  )
