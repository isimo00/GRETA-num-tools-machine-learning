clear
format long
load fisheriris.mat

%Extraction of the values of Iris Fisher
for i=1:100
   if i<=50
       X(i,1)=1;
       X(i,2)=meas(i,1);
       X(i,3)=meas(i,2);
       Y(i,1)=0;
   else 
       X(i,1)=1;
       X(i,2)=meas(i,1);
       X(i,3)=meas(i,2);
       Y(i,1)=1;
   end
   
end
 theta=ones(3,1);
 px=zeros(length(X),size(theta,1));
 

for i=1:length(X)   
   thetax=(theta(1)*X(i,1))+(theta(2)*X(i,2))+(theta(3)*X(i,3));
   px(i,1)=exp(thetax)/(1+exp(thetax));
end
    
sum_der=0;    
 for n=1:length(X)
    aux=(px(n)-Y(n,1))*X(n,1);
    sum_der=sum_der+aux;
 end
 dervJ=sum_der;
 
%  new_theta=
 
 
 
 