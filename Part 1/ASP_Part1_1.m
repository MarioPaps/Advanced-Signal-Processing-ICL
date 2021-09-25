x=rand(1,10000);
stem(x);
xlabel('Time Index'); ylabel('Amplitude');
title('Uniform Random Process');
axis([0 1000 0 1.1]);
%theoretical mean calculation ->theoretical mean is the mean of the continuous distribution
theor_mean=(1-0)/2;
sample_mean= mean(x);

%theoretical variance calculation
theor_std=sqrt((1-0)^2/12); %(b-a)^2/12 
sample_std=std(x); 

%ensemble of ten 1000-sample realisations
X=[];
for ind=1:10
      tmp=rand(1,1000);
      X=cat(1,X,tmp); %concetenation in horizontal direction
end
mean_rls= mean(X,2); %obtain the mean of each row X(i)
mean_rls= mean_rls'; %transform into row vector
std_rls= std(X,0,2);
std_rls=std_rls';
figure;
subplot(2,1,1);
stem(mean_rls);
xlim([1 10]);
mean_ext=repelem(theor_mean,10);
hold on;
stem(mean_ext);
xlabel('Realisation Index'); ylabel('Mean');
title('Mean of Realisations');
legend('sample mean','theoretical mean');
subplot(2,1,2);
stem(std_rls);
xlim([1 10]);
std_ext=repelem(theor_std,10);
hold on;
stem(std_ext);
xlabel('Realisation Index'); ylabel('Standard Deviation');
title('Standard Deviation of Realisations');
legend('sample st.dev.','theoretical st.dev.');

%histogram and theoretical pdf %1.1.4
figure('DefaultAxesFontSize',14);
fg=histogram(x,'Normalization','Probability'); %use the 1000 samples
pd2 = makedist('Uniform','lower',0,'upper',1); %code to generate continuous uniform distribution
domain=0:0.1:1;
pdf_theor=pdf(pd2,domain);
hold on;
plot(domain, pdf_theor/fg.NumBins,'r','LineWidth',2);
legend('approximate pdf', 'theoretical pdf'); title('PDF Approximation');
ylabel('Probability'); xlabel('x');


%task 1.1.5
xg=randn(1,1000); %xg: Gaussian random variable (standard normal)
figure;
stem(xg);
xlabel('Index'); ylabel('Amplitude');
title('Standard Normal Random Process');
mu=0;
sigma=1;
xg_sample_mean= mean(xg);
xg_sample_std=std(xg);
%ensemble of 10 1000-sample realisations
XG=[];
for index=1:10
    tmp=randn(1,1000);
     XG=cat(1,XG,tmp);
end
mean_grls=mean(XG,2);
mean_grls=mean_grls';
mean_bias=0-mean_grls;
std_grls=std(XG,0,2);
std_grls=std_grls';
std_bias=1-std_grls;

figure;
subplot(2,1,1);
mu_ext=repelem(mu,10);
stem(mean_bias);
% hold on;
% stem(mu_ext);
xlabel('Realisation Index'); ylabel('Mean Bias');
xlim([1 10]);
title('Mean Bias Measurement');
legend('sample mean bias','theoretical mean');

subplot(2,1,2);
sigma_ext=repelem(sigma,10);
stem(std_bias,'Color','Red');
% hold on;
% stem(sigma_ext);
xlabel('Realisation Index'); ylabel('Standard Deviation');
xlim([1 10]);
title('Standard Deviation Bias Measurement');
legend('sample st.dev. bias','theoretical st.dev.');

%histogram and theoretical pdf
figure('DefaultAxesFontSize',14);
normal_hist=histogram(XG,'Normalization','pdf'); 
domain_g=[-10:0.1:10];
std_norm=normpdf(domain_g,0,1);
hold on;
plot(domain_g,std_norm,'g','LineWidth',2); %normal_hist.NumBins
ax.FontSize = 67;
legend('approximate pdf', 'theoretical pdf');
ylabel('Probability'); xlabel('x');

fh = findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 14);


