%% fetch.m
%% A function to fetch an instruction from the instruction memory.
%% Inputs 
%% 	nop: 1-bit. If set to 1, does not fetch an instruction (because of stall or hazard mitigation)
%%	currentPC: 16-bit. The current program counter
%%	branch: 1-bit. If set to 1, we are branching and need to fetch the correct instruction
%%	branchOffset: 12-bit. A 12-bit offset from the currentPC
%%	instructionMem: Holds instructions in bit-string format (32-bits wide) 
%% Outputs
%%	nop: 1-bit. Informs the next pipeline stage whether to execute or not depending on if it fetched an instruction or not
%%	nextPC: 16-bit. Program counter for the next fetch
%%	instr: 32-bit. The instruction just fetched
%%
%% - Wesley Chavez 2/14/16

function [nop nextPC instr] = fetch(nop,currentPC,branch,branchOffset,instructionMem)
	if (nop) % Don't fetch an instruction
		nextPC = currentPC;
		instr = '11010000000000000000000000000000';
		return;
	end
	if (strcmp(branch,'0'))	% If no branch, fetch currentPC's instruction and add 4 to PC
		instr = instructionMem{bin2dec(currentPC)+1};
		nextPC = dec2bin(bin2dec(currentPC)+4,16)(end-15:end);
	else % If branch, first bit of offset says if the branch is forward or backward.  Calculate the correct branch address, fetch the instruction, and increment the PC
		backward = branchOffset(1);
		if (strcmp(backward,'1'))
			branchAddress = dec2bin(bin2dec(currentPC) - 8 - bin2dec(branchOffset(2:end)),16)(end-15:end);	
		else
			branchAddress = dec2bin(bin2dec(currentPC) - 8 + bin2dec(branchOffset(2:end)),16)(end-15:end);	
		end
		instr = instructionMem{bin2dec(branchAddress)+1}; 
		nextPC = dec2bin(bin2dec(branchAddress)+4,16)(end-15:end);	
	end
end
