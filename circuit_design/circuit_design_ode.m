function dy = circuit_design_ode(t,y) 
a=1;b=2;c=3;d=4;g=5;
ORgate_A_E__e=6;ORgate_B_E__e=7;ORthd_E=8;e=9;ORgate_C_F__f=10;
ORgate_D_F__f=11;ORthd_F=12;f=13;ANDgate_E_G__g=14;ANDgate_F_G__g=15;
ANDthd_G=16;

k_app=2*10^5;
k_app_thd=10^6;
dy=zeros(16,1);

dy(a)=-k_app*y(a)*y(ORgate_A_E__e);
dy(b)=-k_app*y(b)*y(ORgate_B_E__e);
dy(c)=-k_app*y(c)*y(ORgate_C_F__f);
dy(d)=-k_app*y(d)*y(ORgate_D_F__f);
dy(g)=-k_app_thd*y(g)*y(ANDthd_G)+k_app*y(e)*y(ANDgate_E_G__g)+k_app*y(f)*y(ANDgate_F_G__g);
dy(ORgate_A_E__e)=-k_app*y(a)*y(ORgate_A_E__e);
dy(ORgate_B_E__e)=-k_app*y(b)*y(ORgate_B_E__e);
dy(ORthd_E)=-k_app_thd*y(e)*y(ORthd_E);
dy(e)=-k_app_thd*y(e)*y(ORthd_E)-k_app*y(e)*y(ANDgate_E_G__g)+k_app*y(a)*y(ORgate_A_E__e)+k_app*y(b)*y(ORgate_B_E__e);
dy(ORgate_C_F__f)=-k_app*y(c)*y(ORgate_C_F__f);
dy(ORgate_D_F__f)=-k_app*y(d)*y(ORgate_D_F__f);
dy(ORthd_F)=-k_app_thd*y(f)*y(ORthd_F);
dy(f)=-k_app_thd*y(f)*y(ORthd_F)-k_app*y(f)*y(ANDgate_F_G__g)+k_app*y(c)*y(ORgate_C_F__f)+k_app*y(d)*y(ORgate_D_F__f);
dy(ANDgate_E_G__g)=-k_app*y(e)*y(ANDgate_E_G__g);
dy(ANDgate_F_G__g)=-k_app*y(f)*y(ANDgate_F_G__g);
dy(ANDthd_G)=-k_app_thd*y(g)*y(ANDthd_G);

end
