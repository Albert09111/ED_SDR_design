function [circuit_seq_info] = AutoCircuitDesign(design_script_name)
 %function [circuit_seq_info] = AutoCircuitDesign(design_script_name)
 
addpath('lib');
 
[input_info,output_info,gate_info] = parseScript2domain(design_script_name);
input_output_info = [input_info;output_info];

domain_set = {'null'};

for c1 = 1:size(gate_info,1)
    gate_name = gate_info{c1,1};
    for c2 = 2:size(gate_info,2)
       domain = gate_info{c1,c2};
       if isempty(find(strcmp(domain_set,domain),1));
           domain_set{end+1,:} = domain;
       else
       end        
    end
    lock_domain = sprintf('%s_lock',gate_name);
    domain_set{end+1,:} = lock_domain;
end

domain_set(1,:) = [];

domain_num = length(domain_set);

signal_domain_lengh = 15;
lock_length = 7;
domain_seq_set = OthogDomainGen(signal_domain_lengh,domain_num);

domain_seq = [domain_set,domain_seq_set];

circuit_seq_info = {'gate_name','Bot1','Bot2','Top','Thredhold'};


for c4 = 1:size(input_output_info,1)
    input_output_name = input_output_info{c4,1};
    input_output_domain = input_output_info{c4,2};
    input_output_name_index = find(strcmp(domain_seq,input_output_domain));
    gate_input1_seq = domain_seq{input_output_name_index,2};
    
    circuit_seq_info(end+1,:) = {input_output_name,gate_input1_seq,'','',''};
end

for c3 = 1:size(gate_info,1)
    gate_name = gate_info{c3,1};
    gate_input1 = gate_info{c3,2};
    gate_input2 = gate_info{c3,3};
    gate_output = gate_info{c3,4};
    gate_lock = sprintf('%s_lock',gate_name);
    
    gate_input1_index = find(strcmp(domain_seq,gate_input1));
    gate_input1_seq = domain_seq{gate_input1_index,2};

    gate_input2_index = find(strcmp(domain_seq,gate_input2));
    gate_input2_seq = domain_seq{gate_input2_index,2};

    gate_lock_index = find(strcmp(domain_seq,gate_lock));
    gate_lock_seq = domain_seq{gate_lock_index,2};
    
    gate_output_index = find(strcmp(domain_seq,gate_output));
    gate_output_seq = domain_seq{gate_output_index,2};
    
    strand_B1 = [gate_output_seq,gate_lock_seq,gate_input1_seq];
    strand_B2 = [gate_output_seq,gate_lock_seq,gate_input2_seq];
    strand_thresh = [gate_output_seq,gate_lock_seq(1:lock_length)];
    strand_T = d_revcomp([gate_output_seq,gate_lock_seq]);
    
    circuit_seq_info(end+1,:) = {gate_name,strand_B1,strand_B2,strand_T,strand_thresh};
end
    writeCSVFilefromStructure('circuit_design_seq.csv',circuit_seq_info);
end

