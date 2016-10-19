function [instructionMem] = Instructions2Bits(textfile)
fid = fopen(textfile);
instrs = textscan(fid,'%s', 'Delimiter', '\n');
for i = 1:length(instrs{1})
	c = strsplit(instrs{1}{i});
	if (strcmp(c{1},'ADD') | strcmp(c{1},'SUB') | strcmp(c{1},'MUL') | strcmp(c{1},'OR') | strcmp(c{1},'AND') | strcmp(c{1},'XOR'))
		if (strcmp(c{1},'ADD'))
			instrMem{i}(1:4) = '0000';
		elseif (strcmp(c{1},'SUB'))
			instrMem{i}(1:4) = '0001';
		elseif (strcmp(c{1},'MUL'))
			instrMem{i}(1:4) = '0010';
		elseif (strcmp(c{1},'OR'))
			instrMem{i}(1:4) = '0011';
		elseif (strcmp(c{1},'AND'))
			instrMem{i}(1:4) = '0100';
		elseif (strcmp(c{1},'XOR'))
			instrMem{i}(1:4) = '0101';
		end
		for j = 2:3
			if(strcmp(c{j},'R0'))
				instrMem{i}((j-1)*4+1:j*4) = '0000';
			elseif(strcmp(c{j},'R1'))
				instrMem{i}((j-1)*4+1:j*4) = '0001';
			elseif(strcmp(c{j},'R2'))
				instrMem{i}((j-1)*4+1:j*4) = '0010';
			elseif(strcmp(c{j},'R3'))
				instrMem{i}((j-1)*4+1:j*4) = '0011';
			elseif(strcmp(c{j},'R4'))
				instrMem{i}((j-1)*4+1:j*4) = '0100';
			elseif(strcmp(c{j},'R5'))
				instrMem{i}((j-1)*4+1:j*4) = '0101';
			elseif(strcmp(c{j},'R6'))
				instrMem{i}((j-1)*4+1:j*4) = '0110';
			elseif(strcmp(c{j},'R7'))
				instrMem{i}((j-1)*4+1:j*4) = '0111';
			elseif(strcmp(c{j},'R8'))
				instrMem{i}((j-1)*4+1:j*4) = '1000';
			elseif(strcmp(c{j},'R9'))
				instrMem{i}((j-1)*4+1:j*4) = '1001';
			elseif(strcmp(c{j},'R10'))
				instrMem{i}((j-1)*4+1:j*4) = '1010';
			elseif(strcmp(c{j},'R11'))
				instrMem{i}((j-1)*4+1:j*4) = '1011';
			elseif(strcmp(c{j},'R12'))
				instrMem{i}((j-1)*4+1:j*4) = '1100';
			elseif(strcmp(c{j},'R13'))
				instrMem{i}((j-1)*4+1:j*4) = '1101';
			elseif(strcmp(c{j},'R14'))
				instrMem{i}((j-1)*4+1:j*4) = '1110';
			elseif(strcmp(c{j},'R15'))
				instrMem{i}((j-1)*4+1:j*4) = '1111';
			end
		end
		if (strcmp(c{4}(1),'#'))
			instrMem{i}(13) = '1';
			instrMem{i}(14:16) = '000';
			instrMem{i}(17:32) = dec2bin(hex2dec(c{4}(2:end)),16);
		else
			instrMem{i}(13:16) = '0000';
			instrMem{i}(21:32) = '000000000000';
			if(strcmp(c{4},'R0'))
				instrMem{i}(17:20) = '0000';
			elseif(strcmp(c{4},'R1'))
				instrMem{i}(17:20) = '0001';
			elseif(strcmp(c{4},'R2'))
				instrMem{i}(17:20) = '0010';
			elseif(strcmp(c{4},'R3'))
				instrMem{i}(17:20) = '0011';
			elseif(strcmp(c{4},'R4'))
				instrMem{i}(17:20) = '0100';
			elseif(strcmp(c{4},'R5'))
				instrMem{i}(17:20) = '0101';
			elseif(strcmp(c{4},'R6'))
				instrMem{i}(17:20) = '0110';
			elseif(strcmp(c{4},'R7'))
				instrMem{i}(17:20) = '0111';
			elseif(strcmp(c{4},'R8'))
				instrMem{i}(17:20) = '1000';
			elseif(strcmp(c{4},'R9'))
				instrMem{i}(17:20) = '1001';
			elseif(strcmp(c{4},'R10'))
				instrMem{i}(17:20) = '1010';
			elseif(strcmp(c{4},'R11'))
				instrMem{i}(17:20) = '1011';
			elseif(strcmp(c{4},'R12'))
				instrMem{i}(17:20) = '1100';
			elseif(strcmp(c{4},'R13'))
				instrMem{i}(17:20) = '1101';
			elseif(strcmp(c{4},'R14'))
				instrMem{i}(17:20) = '1110';
			elseif(strcmp(c{4},'R15'))
				instrMem{i}(17:20) = '1111';
			end
		end
	elseif (strcmp(c{1},'LOAD')) 	
		instrMem{i}(1:4) = '0110';
		instrMem{i}(9:16) = '00000000';
 
		if(strcmp(c{2},'R0'))
			instrMem{i}(5:8) = '0000';
		elseif(strcmp(c{2},'R1'))
			instrMem{i}(5:8) = '0001';
		elseif(strcmp(c{2},'R2'))
			instrMem{i}(5:8) = '0010';
		elseif(strcmp(c{2},'R3'))
			instrMem{i}(5:8) = '0011';
		elseif(strcmp(c{2},'R4'))
			instrMem{i}(5:8) = '0100';
		elseif(strcmp(c{2},'R5'))
			instrMem{i}(5:8) = '0101';
		elseif(strcmp(c{2},'R6'))
			instrMem{i}(5:8) = '0110';
		elseif(strcmp(c{2},'R7'))
			instrMem{i}(5:8) = '0111';
		elseif(strcmp(c{2},'R8'))
			instrMem{i}(5:8) = '1000';
		elseif(strcmp(c{2},'R9'))
			instrMem{i}(5:8) = '1001';
		elseif(strcmp(c{2},'R10'))
			instrMem{i}(5:8) = '1010';
		elseif(strcmp(c{2},'R11'))
			instrMem{i}(5:8) = '1011';
		elseif(strcmp(c{2},'R12'))
			instrMem{i}(5:8) = '1100';
		elseif(strcmp(c{2},'R13'))
			instrMem{i}(5:8) = '1101';
		elseif(strcmp(c{2},'R14'))
			instrMem{i}(5:8) = '1110';
		elseif(strcmp(c{2},'R15'))
			instrMem{i}(5:8) = '1111';
		end
		instrMem{i}(17:32) = dec2bin(hex2dec(c{3}(2:end)),16);
	elseif (strcmp(c{1},'STORE')) 
		instrMem{i}(1:4) = '0111';
		instrMem{i}(5:8) = '0000';
		instrMem{i}(13:16) = '0000';
 
		if(strcmp(c{2},'R0'))
			instrMem{i}(9:12) = '0000';
		elseif(strcmp(c{2},'R1'))
			instrMem{i}(9:12) = '0001';
		elseif(strcmp(c{2},'R2'))
			instrMem{i}(9:12) = '0010';
		elseif(strcmp(c{2},'R3'))
			instrMem{i}(9:12) = '0011';
		elseif(strcmp(c{2},'R4'))
			instrMem{i}(9:12) = '0100';
		elseif(strcmp(c{2},'R5'))
			instrMem{i}(9:12) = '0101';
		elseif(strcmp(c{2},'R6'))
			instrMem{i}(9:12) = '0110';
		elseif(strcmp(c{2},'R7'))
			instrMem{i}(9:12) = '0111';
		elseif(strcmp(c{2},'R8'))
			instrMem{i}(9:12) = '1000';
		elseif(strcmp(c{2},'R9'))
			instrMem{i}(9:12) = '1001';
		elseif(strcmp(c{2},'R10'))
			instrMem{i}(9:12) = '1010';
		elseif(strcmp(c{2},'R11'))
			instrMem{i}(9:12) = '1011';
		elseif(strcmp(c{2},'R12'))
			instrMem{i}(9:12) = '1100';
		elseif(strcmp(c{2},'R13'))
			instrMem{i}(9:12) = '1101';
		elseif(strcmp(c{2},'R14'))
			instrMem{i}(9:12) = '1110';
		elseif(strcmp(c{2},'R15'))
			instrMem{i}(9:12) = '1111';
		end
		instrMem{i}(17:32) = dec2bin(hex2dec(c{3}(2:end)),16);
	elseif (strcmp(c{1},'BZ') | strcmp(c{1},'BP') | strcmp(c{1},'BN'))
		if (strcmp(c{1},'BZ'))
			instrMem{i}(1:4) = '1000';
		elseif (strcmp(c{1},'BP'))
			instrMem{i}(1:4) = '1010';
		else 
			instrMem{i}(1:4) = '1011';
		end

		instrMem{i}(5:8) = '0000';
		instrMem{i}(13:20) = '00000000';
		
		if(strcmp(c{2},'R0'))
			instrMem{i}(9:12) = '0000';
		elseif(strcmp(c{2},'R1'))
			instrMem{i}(9:12) = '0001';
		elseif(strcmp(c{2},'R2'))
			instrMem{i}(9:12) = '0010';
		elseif(strcmp(c{2},'R3'))
			instrMem{i}(9:12) = '0011';
		elseif(strcmp(c{2},'R4'))
			instrMem{i}(9:12) = '0100';
		elseif(strcmp(c{2},'R5'))
			instrMem{i}(9:12) = '0101';
		elseif(strcmp(c{2},'R6'))
			instrMem{i}(9:12) = '0110';
		elseif(strcmp(c{2},'R7'))
			instrMem{i}(9:12) = '0111';
		elseif(strcmp(c{2},'R8'))
			instrMem{i}(9:12) = '1000';
		elseif(strcmp(c{2},'R9'))
			instrMem{i}(9:12) = '1001';
		elseif(strcmp(c{2},'R10'))
			instrMem{i}(9:12) = '1010';
		elseif(strcmp(c{2},'R11'))
			instrMem{i}(9:12) = '1011';
		elseif(strcmp(c{2},'R12'))
			instrMem{i}(9:12) = '1100';
		elseif(strcmp(c{2},'R13'))
			instrMem{i}(9:12) = '1101';
		elseif(strcmp(c{2},'R14'))
			instrMem{i}(9:12) = '1110';
		elseif(strcmp(c{2},'R15'))
			instrMem{i}(9:12) = '1111';
		end
		instrMem{i}(21:32) = dec2bin(hex2dec(c{3}(2:end)),12);
	elseif (strcmp(c{1},'BEQ'))
		instrMem{i}(1:4) = '1001';
		instrMem{i}(5:8) = '0000';
		instrMem{i}(13:16) = '0000';
		
		if(strcmp(c{2},'R0'))
			instrMem{i}(9:12) = '0000';
		elseif(strcmp(c{2},'R1'))
			instrMem{i}(9:12) = '0001';
		elseif(strcmp(c{2},'R2'))
			instrMem{i}(9:12) = '0010';
		elseif(strcmp(c{2},'R3'))
			instrMem{i}(9:12) = '0011';
		elseif(strcmp(c{2},'R4'))
			instrMem{i}(9:12) = '0100';
		elseif(strcmp(c{2},'R5'))
			instrMem{i}(9:12) = '0101';
		elseif(strcmp(c{2},'R6'))
			instrMem{i}(9:12) = '0110';
		elseif(strcmp(c{2},'R7'))
			instrMem{i}(9:12) = '0111';
		elseif(strcmp(c{2},'R8'))
			instrMem{i}(9:12) = '1000';
		elseif(strcmp(c{2},'R9'))
			instrMem{i}(9:12) = '1001';
		elseif(strcmp(c{2},'R10'))
			instrMem{i}(9:12) = '1010';
		elseif(strcmp(c{2},'R11'))
			instrMem{i}(9:12) = '1011';
		elseif(strcmp(c{2},'R12'))
			instrMem{i}(9:12) = '1100';
		elseif(strcmp(c{2},'R13'))
			instrMem{i}(9:12) = '1101';
		elseif(strcmp(c{2},'R14'))
			instrMem{i}(9:12) = '1110';
		elseif(strcmp(c{2},'R15'))
			instrMem{i}(9:12) = '1111';
		end

		if(strcmp(c{3},'R0'))
			instrMem{i}(17:20) = '0000';
		elseif(strcmp(c{3},'R1'))
			instrMem{i}(17:20) = '0001';
		elseif(strcmp(c{3},'R2'))
			instrMem{i}(17:20) = '0010';
		elseif(strcmp(c{3},'R3'))
			instrMem{i}(17:20) = '0011';
		elseif(strcmp(c{3},'R4'))
			instrMem{i}(17:20) = '0100';
		elseif(strcmp(c{3},'R5'))
			instrMem{i}(17:20) = '0101';
		elseif(strcmp(c{3},'R6'))
			instrMem{i}(17:20) = '0110';
		elseif(strcmp(c{3},'R7'))
			instrMem{i}(17:20) = '0111';
		elseif(strcmp(c{3},'R8'))
			instrMem{i}(17:20) = '1000';
		elseif(strcmp(c{3},'R9'))
			instrMem{i}(17:20) = '1001';
		elseif(strcmp(c{3},'R10'))
			instrMem{i}(17:20) = '1010';
		elseif(strcmp(c{3},'R11'))
			instrMem{i}(17:20) = '1011';
		elseif(strcmp(c{3},'R12'))
			instrMem{i}(17:20) = '1100';
		elseif(strcmp(c{3},'R13'))
			instrMem{i}(17:20) = '1101';
		elseif(strcmp(c{3},'R14'))
			instrMem{i}(17:20) = '1110';
		elseif(strcmp(c{3},'R15'))
			instrMem{i}(17:20) = '1111';
		end
		instrMem{i}(21:32) = dec2bin(hex2dec(c{4}(2:end)),12);
	elseif (strcmp(c{1},'JR'))
		instrMem{i}(1:4) = '1100';
		instrMem{i}(21:32) = dec2bin(hex2dec(c{2}(2:end)),12);
		instrMem{i}(5:20) = '0000000000000000';
	elseif (strcmp(c{1},'HALT'))
		instrMem{i}(1:4) = '1101';
		instrMem{i}(5:32) = '0000000000000000000000000000';
	end
	instructionMem{(i-1)*4+1} = instrMem{i};		
				
end
fclose(fid);
end
