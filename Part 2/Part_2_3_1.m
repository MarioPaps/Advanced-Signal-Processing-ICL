%stability triangle
M=10000; %number of a1,a2 pairs
N=10000; %number of samples
a1=5.*rand(N,1)-2.5;
a2=3.*rand(N,1)-1.5;
a=cat(2,a1,a2);

x=zeros(M,N);
for ind=1:M
    coeffs=[1,-a(ind,:)];
    noise=randn(N,1);
    x(ind,:)=filter(1,coeffs,noise);
end

%code
N=1000;
a1=(-2.5+5.*rand(1,N))';
a2=(-1.5+3.*rand(1,N))';
a=cat(2,a1,a2); %concatenate the column vectors

%construct AR model
 a=-a;
 ones_mat=ones(height(a),1);
 a_coeff=[ones_mat,a1,a2]; %construct coefficient matrix [1 -a1 -a2]
 M=1000;
 x=zeros(M,N);
 for ind=1:M
     wn=randn(N,1);
     x(ind,:)=filter(1,a_coeff(ind,:),wn);
 end
 
% Extract final values and coeffients
x_final=x(:,length(x));

a_stable = a(abs(x_final) < 1000, :);
figure;
set(gca,'FontSize',11);
hold on;
plot(a_stable(:, 1), a_stable(:, 2), '*');
title('Stability Region for N=10000 samples');
xlabel('a1'); ylabel('a2');
ylim([-1.5 1.5]);
a_unstable=a(abs(x_final)>1000,:);
plot(a_unstable(:, 1), a_unstable(:, 2), '*');
legend('stable','unstable');



