clear
N=1000;
x=randn(N,1);
b=[1,2,3,2,1];
a=[1];
y= filter(b,a,x);
Nw= length(b)-1;
heta= 0.1* randn(N,1); %std*randn()+ mean
z=heta+y;
ord=Nw+1;
%function call to lms for mu=0.01
mu=0.1;
[y_hat,error,evolution]=lms(x,z,mu,ord);

figure;
subplot(1,2,1);
hold on;
plot(evolution(:,1),'Color','b','DisplayName','w[1]');
plot(evolution(:,2),'Color','r','DisplayName','w[2]');
plot(evolution(:,3),'Color','g','DisplayName','w[3]');
plot(evolution(:,4),'Color','[0.2 0.8 0.8]','DisplayName','w[4]');
plot(evolution(:,5),'Color','[1 0.5 0]','DisplayName','w[5]');
hold off;
legend('show');
xlabel('Iteration Number'); ylabel('Amplitude'); title('Evolution for \mu=0.1');

subplot(1,2,2);
plot((1/length(error))*(error.^2),'Color','[0.2 0 0]','DisplayName','Error');
legend('show');
xlabel('Iteration Number'); ylabel('Amplitude'); title('LMS Squared Error for \mu=0.1');

%function call to lms
mu=0.02;
[y_hat,error,evolution]=lms(x,z,mu,ord);

figure;
subplot(1,3,1);
hold on;
plot(evolution(:,1),'Color','b','DisplayName','w[1]');
plot(evolution(:,2),'Color','r','DisplayName','w[2]');
plot(evolution(:,3),'Color','g','DisplayName','w[3]');
plot(evolution(:,4),'Color','[0.2 0.8 0.8]','DisplayName','w[4]');
plot(evolution(:,5),'Color','[1 0.5 0]','DisplayName','w[5]');
hold off;
legend('show');
xlabel('Iteration Number'); ylabel('Amplitude'); title('Evolution for \mu=0.02');

% figure;
% plot(error.^2,'Color','[0.2 0 0]','DisplayName','Error');
% legend('show');
% xlabel('Iteration Number'); ylabel('Amplitude'); title('LMS Squared Error for \mu=0.01');

mu=0.2;
[y_hat,error,evolution]=lms(x,z,mu,ord);


subplot(1,3,2);
hold on;
plot(evolution(:,1),'Color','b','DisplayName','w[1]');
plot(evolution(:,2),'Color','r','DisplayName','w[2]');
plot(evolution(:,3),'Color','g','DisplayName','w[3]');
plot(evolution(:,4),'Color','[0.2 0.8 0.8]','DisplayName','w[4]');
plot(evolution(:,5),'Color','[1 0.5 0]','DisplayName','w[5]');
hold off;
legend('show');
xlabel('Iteration Number'); ylabel('Amplitude'); title(' Evolution for \mu=0.2');

mu=0.5;
[y_hat,error,evolution]=lms(x,z,mu,ord);


subplot(1,3,3);
hold on;
plot(evolution(:,1),'Color','b','DisplayName','w[1]');
plot(evolution(:,2),'Color','r','DisplayName','w[2]');
plot(evolution(:,3),'Color','g','DisplayName','w[3]');
plot(evolution(:,4),'Color','[0.2 0.8 0.8]','DisplayName','w[4]');
plot(evolution(:,5),'Color','[1 0.5 0]','DisplayName','w[5]');
hold off;
legend('show');
xlabel('Iteration Number'); ylabel('Amplitude'); title('Evolution for \mu=0.5');


fh = findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 14);



