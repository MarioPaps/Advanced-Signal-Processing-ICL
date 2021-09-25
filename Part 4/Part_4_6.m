b = 1;
a = [1 0.9 0.2];
N = 1000;
N_w = length(a);
noise = randn(N,1);
x = filter(b, a, noise);

x1=[0;x(1:length(x)-1)];
y=zeros(1,length(x));
err=zeros(1,length(x));
a_x=[0,0];
a_out=a_x;
mu=0.01;
ord=2;

for ind=ord+1:N
    y(ind)= a_x(1)' * x1(ind) + a_x(2)' *x1(ind-1);
    err(ind)= x(ind)-y(ind);
    a_x(1)= a_x(1)+ mu*err(ind)*x1(ind);
    a_x(2)= a_x(2) + mu*err(ind)*x1(ind-1);
    a_out=[a_out; a_x(1),a_x(2)];
end


[~,~,w1] = signed_error(x1, x, mu, 3);
[~,~,w2] = signed_reg(x1, x, mu, 3);
[~,~,w3] = sign_sign(x1, x, mu, 3);

subplot(2,2,1);
hold on;
plot(a_out(:,1),'DisplayName','a1','Color','r');
plot(a_out(:,2),'DisplayName','a2','Color','[0 0.5 1]');
yline(-0.2);
yline(-0.9);
legend('a1','a2');
hold off; xlim([0 1000]);
xlabel('Iteration Number'); ylabel('Value'); 
title('AR LMS,\mu=0.01');

subplot(2,2,2);
hold on;
plot(w1(1,:),'DisplayName','a1','Color','r');
plot(w1(2,:),'DisplayName','a2','Color','[0 0.5 1]');
yline(-0.2);
yline(-0.9);
legend('a1','a2');
hold off;  xlim([0 1000]);
xlabel('Iteration Number'); ylabel('Value'); 
title('Signed Error LMS,\mu=0.01');

subplot(2,2,3);
hold on;
plot(w2(1,:),'DisplayName','a1','Color','r');
plot(w2(2,:),'DisplayName','a2','Color','[0 0.5 1]');
yline(-0.2);
yline(-0.9);
legend('a1','a2');
hold off;  xlim([0 1000]);
xlabel('Iteration Number'); ylabel('Value');
title('Signed Regressor LMS,\mu=0.01');

subplot(2,2,4);
hold on;
plot(w3(1,:),'DisplayName','a1','Color','r');
plot(w3(2,:),'DisplayName','a2','Color','[0 0.5 1]');
yline(-0.2);
yline(-0.9);
legend('a1','a2');
hold off;  xlim([0 1000]);
xlabel('Iteration Number'); ylabel('Value'); 
title('Sign-Sign LMS,\mu=0.01');

fh= findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 14);


function [y,e,w] = signed_error(x,z,mu,order)
Nw = order-1;
w(:,order) = zeros(Nw,1);
y(order) = 0;

for i=order+1:length(x)+1
    y(i-1) = transpose(w(:,i-1))*flipud(x(i-Nw:i-1));
    e(i-1) = z(i-1)-y(i-1);
    w(:,i) = w(:,i-1)+mu*sign(e(i-1))*flipud(x(i-Nw:i-1));
end
end

function [y,e,w] = signed_reg(x,z,mu,order)
    Nw = order-1;
    w(:,order) = zeros(Nw,1);
    y(order) = 0;

    for ind=order+1:length(x)+1
        y(ind-1) = transpose(w(:,ind-1))*flipud(x(ind-Nw:ind-1));
        e(ind-1) = z(ind-1)-y(ind-1);
        w(:,ind) = w(:,ind-1)+mu*e(ind-1)*sign(flipud(x(ind-Nw:ind-1)));   
    end
end

function [y,e,w] =  sign_sign(x,z,mu,order)
    Nw = order-1;
    w(:,order) = zeros(Nw,1);
    y(order) = 0;
for ind=order+1:length(x)+1
    y(ind-1) = transpose(w(:,ind-1))*flipud(x(ind-Nw:ind-1));
    e(ind-1) = z(ind-1)-y(ind-1);
    w(:,ind) = w(:,ind-1)+mu*sign(e(ind-1))*sign(flipud(x(ind-Nw:ind-1)));
end

end
