function [sticky_end_set] = OthogDomainGen(sticky_end_length,pool_size)

    sticky_end_set = {};
    sticky_end_set{end+1} = randseq(sticky_end_length);
    
    while size(sticky_end_set,1) <pool_size
       new_se = randseq(sticky_end_length);
       %fprintf('Seq:%s generated \n',new_se)
       isrepeat = [];
       while ~isempty(strfind(new_se,'AAA'))||~isempty(strfind(new_se,'CCC'))||~isempty(strfind(new_se,'TTT'))||~isempty(strfind(new_se,'GGG')) % check if there is 1 in repeat, if there is, return 0
       new_se = randseq(sticky_end_length);
       end

       compar_set1 = []; % 5 pairing
       compar_set2 = []; % 4 pairing
       compar_set3 = []; % 3 pairing
       %compar_set4 = []; % 2 pairing

       %%% avoid adding complementray sticky end
       for c1 = 1: size(sticky_end_set,1)
           pool_se = sticky_end_set{c1};
           compar_set1(end+1) = strcmp(new_se,pool_se); % different from the pool
           compar_set1(end+1) = strcmp(new_se,d_revcomp(pool_se)); % rev pool newadded
           compar_set1(end+1) = strcmp(d_revcomp(new_se),pool_se); % rev new added vs pool
       end

       %%% avoid adding 4 complementary.
       for c2 = size(sticky_end_set,1)
           pool_se = sticky_end_set{c2};
          for n = 1:sticky_end_length-3
              new_se_4nt = pool_se(n:n+3);
              for m = 1:2
                 pool_se_4nt = new_se(m:m+3);
                 compar_set2(end+1) = strcmp(d_revcomp(new_se_4nt),pool_se_4nt);  % rev pool newadded
                 compar_set2(end+1) = strcmp(new_se_4nt,d_revcomp(pool_se_4nt));  % rev new added vs pool
              end
          end 
       end
       
       %%% avoid adding 3 complementary.
          for c3 = size(sticky_end_set,1)
           pool_se = sticky_end_set{c3};
          for n = 1:sticky_end_length-2
              new_se_4nt = pool_se(n:n+2);
              for m = 1:3
                 pool_se_4nt = new_se(m:m+2);
                 compar_set3(end+1) = strcmp(d_revcomp(new_se_4nt),pool_se_4nt);  % rev pool newadded
                 compar_set3(end+1) = strcmp(new_se_4nt,d_revcomp(pool_se_4nt)); % rev new added vs pool
              end
          end 
          end     
        energy = bind_energy_cal(new_se);  
       if isempty(find(compar_set1 == 1))&&isempty(find(compar_set2 == 1))&&isempty(find(compar_set3 == 1))
        %fprintf('%d sequence : %s found \n',size(sticky_end_set,1),new_se);
        sticky_end_set{end+1,1}=new_se;
       end
    end
    
end

