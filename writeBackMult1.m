%% writeBackMult1.m
%% A function to write back the 16 MSB of a product of multiplication from the ALU to a register in the register file.
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
function [regFile] = writeBackMult1(result, dest, regFile)
	regFile{bin2dec(dest)+1} = result(1:16); %% Big endian, +1 because matlab is 1-indexed
end
