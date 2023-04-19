// Generated from Cirq v1.1.0

OPENQASM 2.0;
include "qelib1.inc";


// Qubits: [q(0), q(1), q(2), q(3), q(4), q(5), q(6), q(7), q(8), q(9)]
qreg q[10];


x q[2];
h q[6];
x q[7];
t q[5];
h q[0];
x q[4];
cx q[1],q[3];
h q[8];
y q[2];
cx q[0],q[5];
h q[4];
s q[1];
t q[7];
cx q[9],q[2];
z q[5];
cx q[7],q[3];
cz q[1],q[8];
z q[0];
t q[2];
s q[9];
cz q[5],q[6];
cx q[4],q[7];
z q[2];
t q[6];
h q[4];
x q[7];
s q[9];
z q[6];
t q[2];
cz q[4],q[1];
cx q[0],q[7];
t q[9];
y q[2];
h q[0];
cx q[9],q[7];
z q[1];
t q[4];
cz q[2],q[6];
t q[0];
z q[7];
h q[9];
cx q[3],q[1];
y q[2];
cx q[9],q[5];
y q[7];
cz q[2],q[8];
t q[8];
t q[8];
