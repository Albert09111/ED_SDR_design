   
    init_conc = 200*10^-9;
    time_span = [1:100];
    
    init_conc_set_00 = [0,0,0,init_conc,init_conc,init_conc];
    init_conc_set_10 = [init_conc,0,0,init_conc,init_conc,init_conc];
    init_conc_set_01 = [0,init_conc,0,init_conc,init_conc,init_conc];
    init_conc_set_11 = [init_conc,init_conc,0,init_conc,init_conc,init_conc];
    
    close all;
    figure(1);
    hold on;
    options = odeset('RelTol',1e-4,'AbsTol',[1e-20]);
    [t,y] = ode23s('AND_gate_ode',time_span,init_conc_set_00,options);
    plot(t,y(:,3),'r','linewidth',2)
    [t,y] = ode23s('AND_gate_ode',time_span,init_conc_set_10,options);
    plot(t,y(:,3),'g','linewidth',2)
    [t,y] = ode23s('AND_gate_ode',time_span,init_conc_set_01,options);
    plot(t,y(:,3),'k','linewidth',2)
    [t,y] = ode23s('AND_gate_ode',time_span,init_conc_set_11,options);
    plot(t,y(:,3),'b','linewidth',2)