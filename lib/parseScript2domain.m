function [IN_info,OUTPUT_info,gate_domain_info] = parseScript2domain(file_name)
    
    IN_info = {};
    OUTPUT_info = {};
    gate_domain_info = {};
    
    fid = fopen(file_name,'r');
    Count = 0;
    while ~feof(fid)
        tline = fgetl(fid);
        Count = Count +1;
        name_index_input = strfind(tline,'input');
        name_index_output = strfind(tline,'output');
        name_index_or = strfind(tline,'OR');
        name_index_and = strfind(tline,'AND');
        
        if ~isempty(name_index_input)
            index_arrow = strfind(tline,'->');
            input_domain = tline(index_arrow+3);
            input_name= sprintf('input_%s',input_domain);
            IN_info(end+1,:) = {input_name,input_domain};            
        end
        
        if ~isempty(name_index_output)
            index_arrow = strfind(tline,'->');
            output_domain = tline(index_arrow+3);
            output_name= sprintf('output_%s',output_domain);
            OUTPUT_info(end+1,:) = {output_name,output_domain};            
        end

        if ~isempty(name_index_or)
           input1 = tline(name_index_or+3);
           input2 = tline(name_index_or+5);
           index_arrow = strfind(tline,'->');
           output = tline(index_arrow+3);
           gate_name = sprintf('%s_%s_OR_%s',input1,input2,output);
           gate_domain_info(end+1,:) = {gate_name,input1,input2,output};
        end
        
        if ~isempty(name_index_and)
           input1 = tline(name_index_and+4);
           input2 = tline(name_index_and+6);
           index_arrow = strfind(tline,'->');
           output = tline(index_arrow+3);
           gate_name = sprintf('%s_%s_AND_%s',input1,input2,output);
           gate_domain_info(end+1,:) = {gate_name,input1,input2,output};
        end
        
%        Count = Count +1;
    end
    fclose(fid);
    
end
