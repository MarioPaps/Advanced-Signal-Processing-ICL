close all
clear
clc
load NASDAQ
close= NASDAQ.Close;
close= close';
date= NASDAQ.Date;
returns= zeros(1,length(close));
for ind=2: length(close)
    returns(1,ind-1)= close(1,ind)/close(1,ind-1);
end
returns= returns-(mean(returns,2))'/(std(returns));
ord=5; %model order
N= length(returns); %size of observed data
[arcoefs,E,K] = aryule(returns,ord);
pacf = -K;
pacf=pacf';
lags=[1:1:ord];

%Model order selection plots
figure;
set(gca,'FontSize',11);
stem(lags,pacf);
xlabel('Lag'); ylabel('Amplitude'); title('Partial ACF of NASDAQ Data');
ylim([-1 1]);

ord=10;
p=[1:ord];
N = length(close);
close_norm= zscore(close);
x = zeros(N,10);
o = ones(1,ord);


for i = 1:ord
    ar = aryule(close_norm(1:N), i);
    x(:,i) = filter(-1*ar(1:end),1,close_norm);
end

Error=zeros(N,ord);
Error(1,:) = (x(1,:)-o*close_norm(1)).^2;

for i=2:N % Can't start with index 1 because of E(i-1)
    Error(i,:) = (x(i,:)-o*close_norm(i)).^2 + Error(i-1,:);
end

MDL = log(Error(N,(1:ord))) + (1:ord)*log(N)/N;
AIC = log(Error(N,(1:ord))) + (1:ord)*2/N;

figure;
set(gca,'FontSize',11);
hold on;
plot(p,MDL);
plot(p,AIC);
xlim([1 ord]);
%plot(p,log(err));
title('Model Order Selection Criteria for NADSAQ Data');
xlabel('Model Order'); ylabel('Magnitude'); legend('MDL','AIC');
hold off;

%CRLB Heatmaps
N=[1:50:1001];
sigmasq=[1:50:1001];
r_xx=(xcorr(zscore(close),'unbiased'))';

[V1,V2] = meshgrid(N, sigmasq);
map1 = 2*(V2.^2)./V1;
map2= (V2)./(V1*r_xx(round(length(r_xx)/2)));

figure;
subplot(1,2,1);
h = heatmap(N,sigmasq, map1);
h.Colormap = parula;
h.ColorScaling ='log';
title('CRLB Variance Heat Map');
xlabel('N');
ylabel('Variance');
subplot(1,2,2);
h = heatmap(N, sigmasq, map2);
h.Colormap = parula;
h.ColorScaling = 'log';
title('a_1 Heat Map');
xlabel('N');
ylabel('Variance');

fh = findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 13);


 
