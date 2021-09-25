%create AR model
clear
rng('default');
a=[1,0.9,0.2];
N=1000;
ord=2;
heta= randn(1,N); %std*randn()+ mean
% a=[a(1) -a(2:end)]; %CAREFUL MATLAB ROUTINES a=[1 -a1 -a2] lec2 sl20
    
x=filter(1,a,heta);
x1=x(1:length(x)-1);
x1=horzcat(zeros(1,1),x1);
y=zeros(1,length(x));
err=zeros(1,length(x));
a_x=[1,1];
a_out=a_x;
mu=0.05;

for ind=ord+1:N
    y(ind)= a_x(1)' * x1(ind) + a_x(2)' *x1(ind-1);
    err(ind)= x(ind)-y(ind);
    a_x(1)= a_x(1)+ mu*err(ind)*x1(ind);
    a_x(2)= a_x(2) + mu*err(ind)*x1(ind-1);
    a_out=[a_out; a_x(1),a_x(2)];
end
  
figure;
hold on;
plot(a_out(:,1),'DisplayName','a1','Color','r');
plot(a_out(:,2),'DisplayName','a2','Color','[0 0.5 1]');
hold off;
yticks(-1:0.2:1); xlim([1 1010]);
xlabel('Iteration Number'); ylabel('Value'); legend('show');
title('Time Evolution of a1,a2 for mu=0.01');


%Evolution for different gains
gains=[0.01 0.05 0.1 0.3];
a_diff=a(2:end);
mu=gains(1); %pick value and plot
[error,evolution]= ar_lms_varying(x,x1,y,a_diff,mu,ord);
subplot(2,2,1);
plot(evolution(:,1),'DisplayName','a1');
hold on;
plot(evolution(:,2),'DisplayName','a2');
hold off; xlabel('Iteration Number'); ylabel('Value');
title('Coefficients for \mu=0.01');
legend('show');

mu=gains(2); %pick value and plot
[error,evolution]= ar_lms_varying(x,x1,y,a_diff,mu,ord);
subplot(2,2,2); 
plot(evolution(:,1),'DisplayName','a1');
hold on;
plot(evolution(:,2),'DisplayName','a2');
hold off; xlabel('Iteration Number'); ylabel('Value');
title('Coefficients for \mu=0.05');
legend('show');

mu=gains(3); %pick value and plot
[error,evolution]= ar_lms_varying(x,x1,y,a_diff,mu,ord);
subplot(2,2,3); 
hold on;
plot(evolution(:,1),'DisplayName','a1');
plot(evolution(:,2),'DisplayName','a2');
hold off; xlabel('Iteration Number'); ylabel('Value');
title('Coefficients for \mu=0.1');
legend('show');

mu=gains(4); %pick value and plot
[error,evolution]= ar_lms_varying(x,x1,y,a_diff,mu,ord);
subplot(2,2,4); 
hold on;
plot(evolution(:,1),'DisplayName','a1');
plot(evolution(:,2),'DisplayName','a2');
hold off; xlabel('Iteration Number'); ylabel('Value');
title('Coefficients for \mu=0.3');
legend('show');


fh= findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 14);



function  [error,evolution]= ar_lms_varying(x,x1,y,a_diff,mu,ord)
    N=length(x);
    error=zeros(1,N);
    evolution=[];
    
    for ind=ord+1:N
        y(ind)= a_diff(1)' * x1(ind) + a_diff(2)' *x1(ind-1);
        error(ind)= x(ind)-y(ind);
        a_diff(1)= a_diff(1)+ mu*error(ind)*x1(ind);
        a_diff(2)= a_diff(2) + mu*error(ind)*x1(ind-1);
        evolution=[evolution ; a_diff(1),a_diff(2)];
    end
end


















