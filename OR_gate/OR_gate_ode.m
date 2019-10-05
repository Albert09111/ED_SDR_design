function dy = OR_gate_ode(t,y) 
a=1;b=2;c=3;ORgate_A_C__c=4;ORgate_B_C__c=5;
ORthd_C=6;

k_app=2*10^5;
k_app_thd=10^6;
dy=zeros(6,1);

dy(a)=-k_app*y(a)*y(ORgate_A_C__c);
dy(b)=-k_app*y(b)*y(ORgate_B_C__c);
dy(c)=-k_app_thd*y(c)*y(ORthd_C)+k_app*y(a)*y(ORgate_A_C__c)+k_app*y(b)*y(ORgate_B_C__c);
dy(ORgate_A_C__c)=-k_app*y(a)*y(ORgate_A_C__c);
dy(ORgate_B_C__c)=-k_app*y(b)*y(ORgate_B_C__c);
dy(ORthd_C)=-k_app_thd*y(c)*y(ORthd_C);

end
