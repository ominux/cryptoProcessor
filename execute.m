%% execute.m
%% A function to execute an istruction (ALU operation, load, store).
%% Inputs 
%% 	nop: 1-bit. If set to 1, does not execute an instruction (because of stall or hazard mitigation)
%%	op: 4-bit operation
%%	rd1: 16-bit S1 value read from regFile
%%	rd2: 16-bit S2 value read from regFile
%%	imm16: 16-bit immediate value
%%	regOrImm: 1-bit value to decode a register read or immediate operand for arithmetic and logical operations
%%	dest: 4-bit destination register
%%	dataMem: data memory, 65K X 16-bit
%%	
%% Outputs
%%	nop: 1-bit. Informs the next pipeline stage whether to execute or not depending on if it fetched an instruction or not
%%	op: 4-bit operation
%%	result: ALU operation result
%%	data: Data read from data memory
%%	dest: Destination register
%%	dataMem: data memory, 65K X 16-bit
%%
%% - Wesley Chavez 2/14/16
function [nop op result data dest dataMem] = execute(nop, op, rd1, rd2, imm16, regOrImm, dest, dataMem)
	if (nop) % Don't execute the instruction
		op = '1111';
		result = '';
		data = '';
		dest = '';
		return;
	end
	if (strcmp(op,'0000')) %Add: register or immediate addressing mode
		if (strcmp(regOrImm,'0'))
			result = dec2bin(bin2dec(rd1) + bin2dec(rd2),16);
			result = result(end-15:end);
		else
			result = dec2bin(bin2dec(rd1) + bin2dec(imm16),16);
			result = result(end-15:end);
		end
		data = '0000000000000000';
	elseif (strcmp(op,'0001')) %Subtract: register or immediate addressing mode
		if (strcmp(regOrImm,'0'))
			if (bin2dec(rd1) > bin2dec(rd2))
				result = dec2bin(bin2dec(rd1) - bin2dec(rd2),16);
			else
				result = dec2bin(bin2dec(rd2) - bin2dec(rd1),16);
			end
			result = result(end-15:end);
		else
			if (bin2dec(rd1) > bin2dec(imm16))
				result = dec2bin(bin2dec(rd1) - bin2dec(imm16),16);
			else
				result = dec2bin(bin2dec(imm16) - bin2dec(rd1),16);
			end
			result = result(end-15:end);
		end
		data = '0000000000000000';
	elseif (strcmp(op,'0010')) %Multiply: returns 32-bit product; register or immediate addressing mode
		if (strcmp(regOrImm,'0'))
			result = dec2bin(bin2dec(rd1) * bin2dec(rd2),32);
			result = result(end-31:end);
		else
			result = dec2bin(bin2dec(rd1) * bin2dec(imm16),32);
			result = result(end-31:end);
		end
		data = '0000000000000000';
	elseif (strcmp(op,'0011')) %bitwise OR: register or immediate addressing mode
		if (strcmp(regOrImm,'0'))
			result = dec2bin(bitor(bin2dec(rd1), bin2dec(rd2)),16);
			result = result(end-15:end);
		else
			result = dec2bin(bitor(bin2dec(rd1),bin2dec(imm16)),16);
			result = result(end-15:end);
		end
		data = '0000000000000000';
	elseif (strcmp(op,'0100')) %bitwise AND: register or immediate addressing mode
		if (strcmp(regOrImm,'0'))
			result = dec2bin(bitand(bin2dec(rd1), bin2dec(rd2)),16);
			result = result(end-15:end);
		else
			result = dec2bin(bitand(bin2dec(rd1),bin2dec(imm16)),16);
			result = result(end-15:end);
		end
		data = '0000000000000000';
	elseif (strcmp(op,'0101')) %bitwise XOR: register or immediate addressing mode
		if (strcmp(regOrImm,'0'))
			result = dec2bin(bitxor(bin2dec(rd1), bin2dec(rd2)),16);
			result = result(end-15:end);
		else
			result = dec2bin(bitxor(bin2dec(rd1),bin2dec(imm16)),16);
			result = result(end-15:end);
		end
		data = '0000000000000000';
	elseif (strcmp(op,'0110')) % Load: immediate addressing mode
		data = dataMem{bin2dec(imm16)+1};
		result = '0000000000000000';
	elseif (strcmp(op,'0111')) % Store: immediate addressing mode
		dataMem{bin2dec(imm16)+1} = rd1;
		result = '0000000000000000';
	end
end
