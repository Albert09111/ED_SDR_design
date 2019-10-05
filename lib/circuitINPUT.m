function [input_name,input_set] = circuitINPUT(input_number)
    dec_set = 0:2^input_number-1;
    bin_set = dec2bin(dec_set);
    input_name =  num2str(bin_set);
    input_set = [];
    
    for c1 = 1:size(bin_set,1)
        for c2 = 1:size(bin_set,2)
            input_set(c1,c2) = str2num(bin_set(c1,c2));            
        end        
    end
    
end