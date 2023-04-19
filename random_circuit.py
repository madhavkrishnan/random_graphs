# code to generate a random Clifford + T circuit

import cirq, json
import numpy.random as random


# Fix random seed
random.seed(10)

qubits = 100
depth = 1000

# Gate filling probability per moment 
p_fill = 0.3

# Set up circuit and qubits
q = [cirq.LineQubit(i) for i in range(qubits)]
circuit = cirq.Circuit()

# Gate list 
sq_gates = [cirq.H, cirq.S, cirq.T, cirq.X, cirq.Y, cirq.Z]
tq_gates = [cirq.CNOT, cirq.CZ]

d = depth
while d > 0:
    
    moment = []
    
    # Select qubits
    sq_index = [i for i in range(qubits)]
    tq_index = list(sq_index)

    sq_gate_no = random.binomial(qubits, p_fill)
    tq_gate_no = random.binomial(qubits // 2 , p_fill)
    
    # Select qubits to act on 
    sq_qubits = list(random.choice(qubits, sq_gate_no, replace=False))
    tq_qubits = random.choice(qubits, (tq_gate_no,2), replace=False)
    tq_qubits = [list(tq) for tq in tq_qubits]
    

    while sq_qubits:
        q_idx = sq_qubits.pop(0)
        moment.append(random.choice(sq_gates)(q[q_idx]))
    
    while tq_qubits:
        qc,qt = tq_qubits.pop(0)
        moment.append(random.choice(tq_gates)(q[qc], q[qt]))

    circuit.append(list(moment))
    
    d -= 1

#print(circuit)

#file_json = f"random_circuit_d{depth}_q{qubits}.json"

# Qasm output
file_qasm = f"random_circuit_d{depth}_q{qubits}.qasm"

with open(file_qasm, 'w') as outfile:
    outfile.write(circuit._qasm_())
 
#file_json = f"random_circuit_d{depth}_q{qubits}.json"

# Generate Cirq JSON
#cjson = cirq.to_json(circuit)
#cjson_str = json.dumps(cjson)
    
# Save Cirq JSON
#with open(file_json, 'w') as outfile:
#    json.dump(cjson, outfile)


    


