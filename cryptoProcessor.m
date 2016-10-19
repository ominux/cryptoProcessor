%% cryptoProcessor.m 
%%
%%	A simulation of a 1-core pipelined in-order load-store processor with 4 stages: 
%%		fetch: Fetches an instruction from instruction memory based on a program counter and
%%			whether or not to branch or jump to a different instruction.
%%		decode: Decodes the fetched instruction, reads the register file, and passes on necessary
%%			bits to execute stage. A few comparators are used here to check whether a branch needs
%%			to be taken.
%%		execute: Executes a given instruction (except for jumps, branches, and halts) using either
%%			the ALU or the memory for loads and stores.
%%		writeBack: Writes back (to the destination register) the output of either the ALU or the
%%			data memory (if load).  If store, this stage stores the contents of a register into
%%			the data memory.
%%	The op codes, instruction set mnemonics, a block diagram of the pipeline, and a few examples
%%	may be found in the README.pdf
%%
%%	In each iteration of the loop, these stages process a different instruction from instrMem with calls
%%	to their functions.  If a hazard is detected, a nop (no operation) may be passed to a pipeline stage
%%	as a way of stalling the pipeline.
%%
%%
%%
%%
%%
%% - Wesley Chavez 2/16/16

% Load program into instruction memory
instrMem = Instructions2Bits('instr.txt');

% Load data to be encrypted into data memory
for i = 1:64
	dataMem{i} = dec2bin(i-1,16);
end

% Initialize registers to zero
for i = 1:16
	regFile{i} = '0000000000000000';
end

% Initialize remaining variables
currentPC = '0000000000000000';
branchOffset = '000000000000';
branch = '0';
nopF = 0;
nopFD = 1;
instr = '11111111111111111111111111111111';
nopDE = 1;
opDE = '1111';
rd1 = '1111';
rd2 = '1111';
imm16 = '1111111111111111';
regOrImm = '1';
destDE = '1111';
nopEWB = 1;
opEWB = '1111';
result = '1111111111111111';
data = '1111111111111111';
destEWB = '1111';
mult2 = 0;
mult1 = 0;

% i keeps track of clock cycles
for i = 1:7
	
	% Print info to screen
	p=['Time: ' num2str(i) ' Fetching: ' currentPC ' Decoding: ' instr ' Executing: ' opDE ' Writing: ' opEWB];
	s = ['nopF: ' num2str(nopF) ' nopFD: ' num2str(nopFD) ' nopDE: ' num2str(nopDE) ' nopEWB: ' num2str(nopEWB)];
	disp(p);
	disp(s);
	% Fetch, decode, and execute
	[nopFDTemp nextPCTemp instrTemp] = fetch(nopF,currentPC,branch,branchOffset,instrMem);
	[nopDETemp opDETemp rd1Temp rd2Temp imm16Temp regOrImmTemp destDETemp branchTemp branchOffsetTemp regFile] = decode(nopFD,instr,regFile);
	[nopEWBTemp opEWBTemp resultTemp dataTemp destEWBTemp dataMem] = execute(nopDE,opDE,rd1,rd2,imm16,regOrImm,destDE,dataMem);

	if (strcmp(opEWB,'0010')) % If multiplication, two write back steps. We've already stalled the instruction after this for one cycle.
		if !(mult1 || mult2)
			[regFile] = writeBackMult1(result,destEWB,regFile); % Write back first 16 bits
			mult1 = 1;
			mult2 = 0;
		elseif (mult1 && !mult2)
			[regFile] = writeBackMult2(result,destEWB,regFile); % Write back second 16 bits next timestep
			mult1 = 0;
			mult2 = 1;
			nopEWB = nopEWBTemp;
			opEWB = opEWBTemp;
			result = resultTemp;
			data = dataTemp;
			destEWB = destEWBTemp;
		end
	else % Regular write-back, only 1 cycle
		[regFile] = writeBack(nopEWB,opEWB,result,data,destEWB,regFile);
		mult1 = 0;
		mult2 = 0;
		nopEWB = nopEWBTemp;
		opEWB = opEWBTemp;
		result = resultTemp;
		data = dataTemp;
		destEWB = destEWBTemp;
	end

	branch = branchTemp; 
	branchOffset = branchOffsetTemp;

	if (strcmp(branchTemp,'1')) % If we have decoded a taken branch
		nopFD = 1; % Don't decode the next instruction (We're taking a branch and that fetched instruction shouldn't be executed)
	else
		nopFD = nopFDTemp;
	end

	if (strcmp(instrTemp(1:4),'1101')) % If HALT, stop fetching & decoding instructions, but finish the execution and write-back of the previous two.
		nopF = 1;
		nopFD = 1;
	end
	if (strcmp(opDETemp,'0010') || (strcmp(destDETemp,instrTemp(9:12)) && !(nopFD)) || (strcmp(destDETemp,instrTemp(17:20)) && !(nopFD) && !(instrTemp(13))) || ...
	(!(mult1 || mult2) && (strcmp(opEWB,'0010')) && (bin2dec(destEWBTemp) == bin2dec(instrTemp(9:12))-1 || bin2dec(destEWBTemp) == bin2dec(instrTemp(17:20))-1)))
	%%%%%% If (We decoded 'MUL' or We decoded a destination where the fetched S1 or S2 needs to read from the register file (RAW hazard) or (we're about to
	%%%%%% write back a multiplication result, which takes 2 cycles, and the next instruction wants to read (S1 or S2) the second 16 bits of the product))
		nopFD = 1;
	else
	%%%%%% Carry on
		currentPC = nextPCTemp;
	end

	instr = instrTemp;
	nopDE = nopDETemp;
	opDE = opDETemp;
	rd1 = rd1Temp;
	rd2 = rd2Temp;
	imm16 = imm16Temp;
	regOrImm = regOrImmTemp;
	destDE = destDETemp;
end
