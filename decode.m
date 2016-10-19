%% Decode.m
%% A function to decode an istruction based on my own instruction set.
%% Inputs 
%% 	nop: 1-bit. If set to 1, does not decode an instruction (because of stall or hazard mitigation)
%%	instr: 32-bit instruction
%%	regFile: Holds 16-bit register values
%% Outputs
%%	nop: 1-bit. Informs the next pipeline stage whether to execute or not depending on if it fetched an instruction or not
%%	op: 4-bit operation
%%	rd1: 16-bit S1 value read from regFile
%%	rd2: 16-bit S2 value read from regFile
%%	imm16: 16-bit immediate value
%%	regOrImm: 1-bit value to decode a register read or immediate operand for arithmetic and logical operations
%%	dest: 4-bit destination register
%%	branch: 1-bit.  Is the branch going to be taken?
%%	branchOffset: Offset of current PC to branch
%% - Wesley Chavez 2/14/16

function [nop op rd1 rd2 imm16 regOrImm dest branch branchOffset regFile] = decode(nop, instr, regFile)
	
	op = instr(1:4);
	if (nop) % Don't decode the instruction
		op = '1111';
		rd1 = '';
		rd2 = '';
		imm16 = '';
		regOrImm = '';
		dest = '';
		branch = '0';
		branchOffset = '000000000000';
		return;
	end
	
	% Assign bits from the instruction
	a1 = instr(9:12);
	a2 = instr(17:20);
	rd1 = regFile{bin2dec(a1)+1};
	rd2 = regFile{bin2dec(a2)+1};
	imm16 = instr(17:32);
	regOrImm = instr(13);
	dest = instr(5:8);
	branchOffset = instr(21:32);
	
	% If JR || BZ || BEQ || BP || BN needs to be taken, we'll know it here
	if( strcmp(op,'1100') || (strcmp(op,'1000') && strcmp(rd1,'0000000000000000')) || (strcmp(op,'1001') && strcmp(rd1,rd2)) ...
	 || (strcmp(op,'1010') && strcmp(rd1(1),0)) || (strcmp(op,'1011') && strcmp(rd1(1),'1')))
		branch = '1';
	else
		branch = '0';
	end
end
