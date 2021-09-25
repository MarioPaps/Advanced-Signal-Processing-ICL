%time-varying adaptation gain
clear
rng('default');

N=1000;
x=randn(N,1);
b=[1,2,3,2,1];
a=[1];
y= filter(b,a,x);
Nw= length(b);
heta= 0.1* randn(N,1); %std*randn()+ mean
z=heta+y;
mu=0.01;

%function call to lms
% mu=[0.1 0.05 0.01 0.002];
% [y_hat,error,evolution,mu_curr]=lms_varying(x,z,mu,Nw,b);
[y_hat,error,evolution]=lms_mu_update(x,z,mu,Nw);

%% plot

% figure;
% hold on;
% plot(evolution(:,1),'Color','b','DisplayName','w[1]');
% plot(evolution(:,2),'Color','r','DisplayName','w[2]');
% plot(evolution(:,3),'Color','g','DisplayName','w[3]');
% plot(evolution(:,4),'Color','[0.2 0.8 0.8]','DisplayName','w[4]');
% plot(evolution(:,5),'Color','[1 0.5 0]','DisplayName','w[5]');
% hold off;
% legend('show');
% xlabel('Iteration Number'); ylabel('Amplitude'); title('Weiner Coefficients Evolution');
% 
% figure;
% plot(error.^2,'Color','[0.2 0 0]','DisplayName','Error');
% legend('show');
% xlabel('Iteration Number'); ylabel('Amplitude'); title('LMS Squared Error');


% plot lms mu update
figure;
subplot(1,2,1);
hold on;
plot(evolution(:,1),'Color','b','DisplayName','w[1]');
plot(evolution(:,2),'Color','r','DisplayName','w[2]');
plot(evolution(:,3),'Color','g','DisplayName','w[3]');
plot(evolution(:,4),'Color','[0.2 0.8 0.8]','DisplayName','w[4]');
plot(evolution(:,5),'Color','[1 0.5 0]','DisplayName','w[5]');
xlim([1 1100]);
yticks(-2:1:16);
hold off;
legend('show');
xlabel('Iteration Number'); ylabel('Amplitude'); title('Gear Shifting Wiener Coefficients');
subplot(1,2,2);
plot((1/length(error))* (error.^2),'Color','[0.2 0 0]','DisplayName','Error');
legend('show');
xlabel('Iteration Number'); ylabel('Amplitude'); title('LMS Error');

fh = findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 14);
%% function call
function  [y_hat,error,evolution,mu_curr]= lms_varying(x,z,mu,ord,b)
    x=x'; %easier to handle row vectors
    z=z'; 
    N=length(x);
    w=zeros(N,ord);
    y_hat=zeros(1,N);
    error=zeros(1,N);
    pos=1;
    mu_curr=mu(pos);
    
    for n=ord+1:N
        x_hat=x(n:-1:n-(ord-1));
        y_hat(1,n)= dot(w(n-ord,:),x_hat);
        error(1,n)= z(1,n)-y_hat(1,n);
         temp= mu_curr*error(1,n) * x_hat;
        w(n+1,:)= w(n,:)+ temp;
        for k=1:ord
            if((w(n+1,k)<0.8 * b(k)) || (w(n+1,k)>1.2*b(k)))
               pos=pos+1;
               if(pos< length(mu))
                    mu_curr= mu(pos);
               end
            end
    end
    
    w_out= w(height(w),:); %what are the final coefficients?
    evolution=w;
    end
end
%%
function [y_hat,error,evolution]= lms_mu_update(x,z,mu,ord)
    x=x'; %easier to handle row vectors
    z=z'; 
    N=length(x);
    w=zeros(N,ord);
    y_hat=zeros(1,N);
    error=zeros(1,N);
    
    for n=ord+1:N
        x_hat=x(n:-1:n-(ord-1));
        y_hat(1,n)= dot(w(n-ord,:),x_hat);
        error(1,n)= z(1,n)-y_hat(1,n);
        if(n>ord+1)
            if(error(1,n)>error(1,n-1))
                mu= 1.2*mu;
            else 
                mu=0.8*mu;
            end
        end
        temp= mu*error(1,n) * x_hat;
        w(n+1,:)= w(n,:)+ temp;
        w_out= w(height(w),:); %what are the final coefficients?
        evolution=w;
    end
end
    
