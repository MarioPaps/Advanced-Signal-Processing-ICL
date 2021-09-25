%load and config
clear 
close all
load RAW-ECG.mat
xRRI1 = data(770:2.5e5);
xRRI2 = data(2.564e5:4.99e5);
xRRI3 = data(5.228e5:7.473e5);
load RRI-DATA.mat

%obtain heart rate
h= 60./xRRI1;

%mean of every 10 samples
cnt=1;
h_avg=zeros(1,floor(length(h)/10) +1);
temp=zeros(1,10);
h_bar= h(1:floor(length(h)/10)*10);

for ind=1:10: floor(length(h)/10)*10
    temp=h_bar(ind:1:ind+9);
    h_avg(cnt)= mean(temp,2);
    cnt=cnt+1;
end
h_fin=h(floor(length(h)/10)*10 +1: length(h));
h_avg(cnt)= mean(h_fin,2);
alpha=1; %alpha can be 1 or 0.6
h_avg= alpha.* h_avg;


nbins=20;
figure;
subplot(3,1,1);
set(gca,'FontSize',11);
pde_original= histogram(h,nbins,'Normalization','pdf');
title('PDE Estimate of Original Heart Rate Data'); xlim([40 120]);
xlabel('Sample Value'); ylabel('Probability');
subplot(3,1,2);
set(gca,'FontSize',11);
pde_avg= histogram(h_avg,nbins,'Normalization','pdf');
title('PDE Estimate of Average Heart Rate Data');
xlabel('Sample Value'); ylabel('Probability'); xlim([40 120]);
alpha=0.6; %changing alpha effect
h_avg= alpha.*h_avg;
subplot(3,1,3);
set(gca,'FontSize',11); xlim([50 120]);
pde_avg6= histogram(h_avg,nbins,'Normalization','pdf');
title('PDE Estimate of Average Heart Rate Data 0.6');
xlabel('Sample Value'); ylabel('Probability'); xlim([50 120]);

%autocorrelation sequence
xRRI1= detrend(xRRI1);
xRRI2= detrend(xRRI2);
xRRI3= detrend(xRRI3);
[acf_1,lags_1]=xcorr(xRRI1,'unbiased');
figure;
subplot(3,1,1);
set(gca,'FontSize',11);
h=stem(lags_1,acf_1);
set(h,'Marker','none');
xlim([-250 250]); 
xlabel('Time Lag'); ylabel('Amplitude'); title('Trial 1');
[acf_2,lags_2]=xcorr(xRRI2,'unbiased');
subplot(3,1,2);
set(gca,'FontSize',11);
h=stem(lags_2,acf_2);
set(h,'Marker','none');
xlim([-250 250]); 
xlabel('Time Lag'); ylabel('Amplitude'); title('Trial 2');
[acf_3,lags_3]=xcorr(xRRI3,'unbiased');
subplot(3,1,3);
set(gca,'FontSize',11);
h=stem(lags_3,acf_3);
set(h,'Marker','none');
xlim([-250 250]); 
xlabel('Time Lag'); ylabel('Amplitude'); title('Trial 3');

%Model Order Selection plots
ord=10;
[~,~,rc1]=aryule(xRRI1,ord);
rc1=-rc1;
N=length(xRRI1);

e1=zeros(1,ord);
for ind=1:ord
    a1=aryule(xRRI1,ind);
    b1=idpoly(a1);
    y1=predict(b1,xRRI1');
    e1(ind)=(1/length(xRRI1))*(y1-xRRI1')'*(y1-xRRI1');
end

p=[1:10];
MDL1=log10(e1)+p.*log10(N)./N;
AIC1=log10(e1)+2*p/N;
AICc1= AIC1+2.*p.*(p+1)./(N-p-1);

figure;
subplot(2,1,1);
stem(p,rc1);
xlabel('Model Order'); ylabel('Amplitude');
title('Trial 1 PACF'); ylim([-1 1]);
subplot(2,1,2);
hold on;
plot(p,MDL1,'DisplayName','MDL');
plot(p,AIC1,'g','DisplayName','AIC'); 
plot(p, AICc1,'r', 'DisplayName','AICc');
hold off;
legend('show');
xlabel('Model Order'); ylabel('Model Value'); title('Trial 1 Model Order Selection');

[~,~,rc2]=aryule(xRRI2,ord);
rc2=-rc2;
N=length(xRRI2);

e2=zeros(1,ord);
for ind=1:ord
    a2=aryule(xRRI2,ind);
    b2=idpoly(a2);
    y2=predict(b2,xRRI2');
    e2(ind)=(1/length(xRRI2))*(y2-xRRI2')'*(y2-xRRI2');
end

p=[1:10];
MDL2=log10(e2)+p.*log10(N)./N;
AIC2=log10(e2)+2*p/N;
AICc2= AIC2+2.*p.*(p+1)./(N-p-1);

figure;
subplot(2,1,1);
stem(p,rc2);
xlabel('Model Order'); ylabel('Amplitude');
title('Trial 2 PACF'); ylim([-1 1]);
subplot(2,1,2);
hold on;
plot(p,MDL2,'DisplayName','MDL');
plot(p,AIC2,'g','DisplayName','AIC'); 
plot(p, AICc2,'r', 'DisplayName','AICc');
hold off;
legend('show');
xlabel('Model Order'); ylabel('Model Value'); title('Trial 2 Model Order Selection');

[~,~,rc3]=aryule(xRRI3,ord);
rc3=-rc3;
N=length(xRRI3);

e3=zeros(1,ord);
for ind=1:ord
    a3=aryule(xRRI3,ind);
    b3=idpoly(a3);
    y3=predict(b3,xRRI3');
    e3(ind)=(1/length(xRRI3))*(y3-xRRI3')'*(y3-xRRI3');
end

p=[1:10];
MDL3=log10(e3)+p.*log10(N)./N;
AIC3=log10(e3)+2*p/N;
AICc3= AIC3+2.*p.*(p+1)./(N-p-1);

figure;
subplot(2,1,1);
stem(p,rc2);
xlabel('Model Order'); ylabel('Amplitude');
title('Trial 3 PACF'); ylim([-1 1]);
subplot(2,1,2);
hold on;
plot(p,MDL3,'DisplayName','MDL');
plot(p,AIC3,'g','DisplayName','AIC'); 
plot(p, AICc3,'r', 'DisplayName','AICc');
hold off;
legend('show');
xlabel('Model Order'); ylabel('Model Value'); title('Trial 3 Model Order Selection');

fh = findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 12.5);