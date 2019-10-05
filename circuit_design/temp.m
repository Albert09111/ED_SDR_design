   
    init_conc = 200*10^-9;
    time_span = [1:100];
    
    init_conc_set = zeros(1,16);
    init_conc_set = repelem(init_conc,16);
    init_conc_set(5) = 0;
    close all;
    figure(1);
    init_conc_set(1:4) = [0,0,0,0];
    options = odeset('RelTol',1e-4,'AbsTol',[1e-20]);
    [t,y] = ode23s('circuit_design_ode',time_span,init_conc_set,options);
    plot(t,y(:,5))