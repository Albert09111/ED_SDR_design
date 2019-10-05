function dy = circuit2_ode(t,y) 
a=1;b=2;c=3;d=4;g=5;
ANDgate_A_E__e=6;ANDgate_B_E__e=7;ANDthd_E=8;e=9;ANDgate_C_F__f=10;
ANDgate_D_F__f=11;ANDthd_F=12;f=13;ANDgate_E_G__g=14;ANDgate_F_G__g=15;
ANDthd_G=16;

k_app=2*10^5;
k_app_thd=10^6;
dy=zeros(16,1);

dy(a)=-k_app*y(a)*y(ANDgate_A_E__e);
dy(b)=-k_app*y(b)*y(ANDgate_B_E__e);
dy(c)=-k_app*y(c)*y(ANDgate_C_F__f);
dy(d)=-k_app*y(d)*y(ANDgate_D_F__f);
dy(g)=-k_app_thd*y(g)*y(ANDthd_G)+k_app*y(e)*y(ANDgate_E_G__g)+k_app*y(f)*y(ANDgate_F_G__g);
dy(ANDgate_A_E__e)=-k_app*y(a)*y(ANDgate_A_E__e);
dy(ANDgate_B_E__e)=-k_app*y(b)*y(ANDgate_B_E__e);
dy(ANDthd_E)=-k_app_thd*y(e)*y(ANDthd_E);
dy(e)=-k_app_thd*y(e)*y(ANDthd_E)-k_app*y(e)*y(ANDgate_E_G__g)+k_app*y(a)*y(ANDgate_A_E__e)+k_app*y(b)*y(ANDgate_B_E__e);
dy(ANDgate_C_F__f)=-k_app*y(c)*y(ANDgate_C_F__f);
dy(ANDgate_D_F__f)=-k_app*y(d)*y(ANDgate_D_F__f);
dy(ANDthd_F)=-k_app_thd*y(f)*y(ANDthd_F);
dy(f)=-k_app_thd*y(f)*y(ANDthd_F)-k_app*y(f)*y(ANDgate_F_G__g)+k_app*y(c)*y(ANDgate_C_F__f)+k_app*y(d)*y(ANDgate_D_F__f);
dy(ANDgate_E_G__g)=-k_app*y(e)*y(ANDgate_E_G__g);
dy(ANDgate_F_G__g)=-k_app*y(f)*y(ANDgate_F_G__g);
dy(ANDthd_G)=-k_app_thd*y(g)*y(ANDthd_G);

end
