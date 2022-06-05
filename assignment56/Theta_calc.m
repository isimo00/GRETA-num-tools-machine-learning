function [new_theta,sum_J,dif]=Theta_calc(tau,theta,X,Y)
    h_theta=X*theta;
    p_x=exp(h_theta)./(1+(exp(h_theta)));
    sum_J=0;
    for i=1:length(X)
       J=((-Y(i,1)*log(p_x(i,1)))-((1-Y(i,1)*log(1-p_x(i,1)))));
       sum_J=sum_J+J;
    end
    sum_derivJ0=0;
    sum_derivJ1=0;
    sum_derivJ2=0;
    for i=1:length(X)
       derivJ0=(p_x(i,1)-Y(i,1))*X(i,1);
       derivJ1=(p_x(i,1)-Y(i,1))*X(i,2);
       derivJ2=(p_x(i,1)-Y(i,1))*X(i,3);
       sum_derivJ0=sum_derivJ0+derivJ0;
       sum_derivJ1=sum_derivJ1+derivJ1;
       sum_derivJ2=sum_derivJ2+derivJ2;
    end
    gradient(1,1)=sum_derivJ0;
    gradient(2,1)=sum_derivJ1;
    gradient(3,1)=sum_derivJ2;

    new_theta=theta-(tau*gradient);
    dif=abs(new_theta-theta);
end
