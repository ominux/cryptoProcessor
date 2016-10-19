%% writeBackMult2.m
%% A function to write back the 16 LSB of a product of multiplication from the ALU to a register in the register file.
%% Inputs
%%	result: 32-bit product
%%	dest: 4-bit destination register
%%	regFile: 65K x 16-bit register file
%%
%%	
%% Outputs
%%	regFile: 65K x 16-bit register file
%%
%% - Wesley Chavez 2/14/16
function [regFile] = writeBackMult2(result, dest, regFile)
	regFile{bin2dec(dest)+2} = result(17:32); %% Big endian, +1 because matlab is 1-indexed
end
