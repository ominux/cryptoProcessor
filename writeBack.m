%% writeBack.m
%% A function to write back a value from the ALU or memory to the register file.
%% Inputs 
%% 	nop: 1-bit. If set to 1, does not write back the data (because of stall or hazard mitigation)
%%	op: 4-bit operation
%%	result: 16-bit ALU result
%%	data: Data read from data memory
%%	dest: 4-bit destination register
%%	regFile: 65K x 16-bit register file
%%
%%	
%% Outputs
%%	regFile: 65K x 16-bit register file
%%
%% - Wesley Chavez 2/14/16
function [regFile] = writeBack(nop, op, result, data, dest, regFile)
	if (nop) % Don't write back to register file
		return;
	end
	if (strcmp(op,'0110'))	% Load command; write back data from memory
		regFile{bin2dec(dest)+1} = data;
	else if (strcmp(op,'0000') || strcmp(op,'0001') || strcmp(op,'0010') || strcmp(op,'0011') || strcmp(op,'0100') || strcmp(op,'0101'))
	% ALU operation. Write back result
		regFile{bin2dec(dest)+1} = result;
	end
end
