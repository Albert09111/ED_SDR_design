%     function parseScript2odeset(file_name)
    
    [INPUT,OUTPUT,gate_domain_info] = parseScript2domain([file_name,'.txt']);
    input_species = INPUT(:,2);
    output_species = OUTPUT(:,2);
    
    gate_species = {'null'};
    
    for c1 = 1:size(gate_domain_info,1)
        gate_name = gate_domain_info{c1,1};
        
        if ~isempty(strfind(gate_name,'OR'))
        
            gate_species{end+1,:} = sprintf('ORgate_%s_%s__%s',...
                                            upper(gate_domain_info{c1,2}),upper(gate_domain_info{c1,4}),gate_domain_info{c1,4});
            gate_species{end+1,:} = sprintf('ORgate_%s_%s__%s',...
                                            upper(gate_domain_info{c1,3}),upper(gate_domain_info{c1,4}),gate_domain_info{c1,4});
            gate_species{end+1,:} = sprintf('ORthd_%s',upper(gate_domain_info{c1,4}));
        
        elseif ~isempty(strfind(gate_name,'AND'))
            gate_species{end+1,:} = sprintf('ANDgate_%s_%s__%s',...
                                            upper(gate_domain_info{c1,2}),upper(gate_domain_info{c1,4}),gate_domain_info{c1,4});
            gate_species{end+1,:} = sprintf('ANDgate_%s_%s__%s',...
                                            upper(gate_domain_info{c1,3}),upper(gate_domain_info{c1,4}),gate_domain_info{c1,4});
            gate_species{end+1,:} = sprintf('ANDthd_%s',upper(gate_domain_info{c1,4}));            
        end
        
        if isempty(find(strcmp(output_species,gate_domain_info{c1,4})))
            gate_species{end+1,:} = sprintf('%s',gate_domain_info{c1,4});            
        end
        
    end
    
    gate_species(1,:) = [];
    
    all_species = [input_species;output_species;gate_species;];
    all_species_index = {};
    
    for c2 = 1:size(all_species,1)
        all_species_index(end+1,:) = {all_species{c2,1},num2str(c2)};
    end
        
    reaction_set = {'reactant1','reactant2','product'};
        
    for c4 = 1:size(all_species,1)
        species = all_species{c4,1};
        if ~isempty(strfind(species,'gate'))
            index = strfind(species,'_');
            reactant1 = lower(species(index(1)+1:index(2)-1));
            reactant2 = species;
            product = species(index(end)+1:end);
            reaction_set(end+1,:) = {reactant1,reactant2,product};
        end
        
        if ~isempty(strfind(species,'thd'))
            index = strfind(species,'_');
            reactant1 = lower(species(index+1:end));
            reactant2 = species;
            product = 'waste';
            reaction_set(end+1,:) = {reactant1,reactant2,product};           
            
        end
        
    end
        
    mkdir(file_name);
    cd(file_name);
    ode_name = sprintf('%s_ode',file_name);
    fid = fopen([ode_name,'.m'],'w');
    
    fprintf(fid,'function dy = %s(t,y) \n',ode_name); 
    
    for c3 = 1:size(all_species_index,1)       
        fprintf(fid,'%s=%s;',all_species_index{c3,1},all_species_index{c3,2});         
        flag = rem(c3,5);      
        if ~flag
        fprintf(fid,'\n');     
        end        
    end
    
    fprintf(fid,'\n\n');
    fprintf(fid,'k_app=2*10^5;\n');
    fprintf(fid,'k_app_thd=10^6;\n');
    fprintf(fid,'dy=zeros(%d,1);',size(all_species,1));
    
    fprintf(fid,'\n\n');
       
    for c5 = 1:size(all_species)
       species = all_species{c5,1};
       fprintf(fid,'dy(%s)=',species);
       
       a = strcmp(reaction_set,species);
       [reaction_index,type_index] =  find(a==1);       
       index = [reaction_index,type_index];
       
       for c6 = 1:size(index,1)
           
           if type_index(c6)<3
               if ~isempty(strfind(reaction_set{reaction_index(c6),2},'thd'))
               fprintf(fid,'-k_app_thd*y(%s)*y(%s)',reaction_set{reaction_index(c6),1},reaction_set{reaction_index(c6),2});
               else
               fprintf(fid,'-k_app*y(%s)*y(%s)',reaction_set{reaction_index(c6),1},reaction_set{reaction_index(c6),2});
               end                  
           end
           
           if type_index(c6)==3
               fprintf(fid,'+k_app*y(%s)*y(%s)',reaction_set{reaction_index(c6),1},reaction_set{reaction_index(c6),2});
           end
           
       end
       fprintf(fid,';\n');
    end
   cd ..
    fprintf(fid,'\nend\n'); 
    fclose(fid);
          
    conc = 200*10^-9;
    
    [input_name,input_set] = circuitINPUT(length(input_species));
    input_conc_set = input_set*conc;
    
    system_conc_set = [];
    for c8 = 1:size(output_species)
        system_conc_set(end+1)=0;
    end
    
    for c9 = 1:size(gate_species)
        species = gate_species{c9,1};
        if ~isempty(strfind(species,'gate'))||~isempty(strfind(species,'ANDthd'))
           system_conc_set(end+1) = conc;
        else
           system_conc_set(end+1) = 0; 
        end
    end

    full_input_set = [];
for c10 = 1:size(input_conc_set)
    input = input_conc_set(c10,:);
    system_conc = system_conc_set;
    full_input_set(end+1,:) = [input,system_conc];
    
end

    time_span = 1:800;

    cd(file_name);

    gca_line_width = 2;
    gca_size = 14;
    lable_size = 32;

    color_set = rand(16,3);
   close all; 
for c11 = 1:size(full_input_set,1)
        figure(1);
        hold on;
        cur_input_name = input_name(c11,:);
        input_conc_set = full_input_set(c11,:);
        options = odeset('RelTol',1e-4,'AbsTol',[1e-20]);
        [t,y] = ode23s(sprintf('%s',ode_name),time_span,input_conc_set,options);
        plot(t,y(:,length(input_species)+1),'Color',color_set(c11,:),'linewidth',2);
end
        ylim([0 200*10^-9]);
        axis square;
        %title(file_name,'fontsize',36);
        set(gca,'fontsize',24,'linewidth',2);
        xlabel('Time(s)');
        ylabel('Output');
        legend(input_name,'Location','EastOutside');
        print(1,'-r300','-dpng',sprintf('%s.png',cur_input_name));

     cd ..
  %end
  




