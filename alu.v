module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;
	
	//add and sub
	wire [31:0] not_B;
	wire [31:0] comp_B;
	wire cout;
	wire sum_last;
	wire cin_last;
	
	not_32bit n0(data_operandB, not_B);
	mux_32bit m0(data_operandB, not_B, ctrl_ALUopcode, comp_B);
	
	csa_adder_32bit a0(data_operandA, comp_B, ctrl_ALUopcode, cout, data_result);
	
	//compute cin of last bit, if cin == 1, last bit of result must be different from A[31] xor B[31]
	xor(sum_last, data_operandA[31], comp_B[31]);
	xor(cin_last, sum_last, data_result[31]);
	//determine overflow by cin xor cout
	xor(overflow, cin_last, cout);
	
	//shift
	
endmodule
