# ALU-Implementation--VHDL
In this project, we implemented an ALU unit. The system receives two input vectors and an operation code, determining which calculation to perform. It consists of three submodules: ADD/SUB, SHIFTER, and LOGIC. The output includes the calculation result and four flags: N (negative), C (carry), V (overflow), and Z (zero).
![image](https://github.com/user-attachments/assets/a5c4c1c0-8da3-4870-9a4a-2276632e7b95)

ALU Instruction Set Architecture (ISA) Specification
![image](https://github.com/user-attachments/assets/571c1ba4-083e-4092-a3f0-d80cbf43268d)

Arithmetic Unit:
Implements addition, subtraction, and negation using a ripple-carry adder. Based on the ALUFN opcode, we manipulate the input vectors—for example, by inverting one operand and setting the carry-in—to support both addition and subtraction within the same adder structure. Operations include Y + X (01000), Y - X (01001), and -X (01010).

Shifter Unit:
Performs logical left and right shifts based on the 3 least significant bits of input X, which determine the number of shift positions. The shift operation is implemented using a matrix of shift vectors, enabling efficient step-wise shifting. Supported operations include shift left (10000) and shift right (10001).

Boolean Unit:
Executes bitwise logic operations between the inputs. It includes operations like NOT (11000), OR (11001), AND (11010), XOR (11011), NOR (11100), NAND (11101), and XNOR (11111). These are vital for control flow, masking, and logical condition evaluations in digital systems.

Top leve:
The top-level ALU module integrates all sub-units. It receives input vectors and an operation code from the user, activates only the relevant sub-unit, and sets all others to high-impedance (High-Z). If an invalid control signal is received, the output is set to 0. The module also returns status flags (Z, N, C, V) based on the selected sub-unit's result. We verified the ALU’s functionality through simulation in ModelSim.

![image](https://github.com/user-attachments/assets/6430c41d-6c70-4acf-b2e8-c3b5c62af3bc)
![image](https://github.com/user-attachments/assets/a69a04f7-306d-4de1-ae58-4fe514d89f04)





