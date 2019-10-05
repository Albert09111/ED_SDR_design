function dy = AND_gate_ode(t,y) 
a=1;b=2;c=3;ANDgate_A_C__c=4;ANDgate_B_C__c=5;
ANDthd_C=6;

k_app=2*10^5;
k_app_thd=10^6;
dy=zeros(6,1);

dy(a)=-k_app*y(a)*y(ANDgate_A_C__c);
dy(b)=-k_app*y(b)*y(ANDgate_B_C__c);
dy(c)=-k_app_thd*y(c)*y(ANDthd_C)+k_app*y(a)*y(ANDgate_A_C__c)+k_app*y(b)*y(ANDgate_B_C__c);
dy(ANDgate_A_C__c)=-k_app*y(a)*y(ANDgate_A_C__c);
dy(ANDgate_B_C__c)=-k_app*y(b)*y(ANDgate_B_C__c);
dy(ANDthd_C)=-k_app_thd*y(c)*y(ANDthd_C);

end
