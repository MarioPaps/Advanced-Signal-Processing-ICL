load sunspot.dat
data=sunspot(:,2);

data=data';
%N=5
data_5=data(1,1:5);
data_5_zm=(data_5-(mean(data_5,2)'));
[acf5,l5]= xcorr(data_5,'unbiased');
[acfzm5,lz5]= xcorr(data_5_zm,'unbiased');
figure;
% subplot(2,1,1);
stem(l5,acf5);
xlabel('Lag'); ylabel('Amplitude'); title('Sunspot Data ACF for N=5 samples');
hold on;
stem(l5,acfzm5);
hold off;
legend('mean','zero mean');
xlabel('Lag'); ylabel('Amplitude'); title('Centered and Scaled Sunspot Data ACF for N=5 samples');
axis([-5 5 -500 500]); 

%N=20
data_20=data(1,1:20);
data_20_zm=(data_20-(mean(data_20,2)')); %/((std(data_20)'));
[acf20,l20]= xcorr(data_20,'unbiased');
[acfzm20,lz20]=xcorr(data_20_zm,'unbiased');
figure;
% subplot(2,1,1);
stem(l20,acf20);
xlabel('Lag'); ylabel('Amplitude'); title('Sunspot Data ACF for N=20 samples');
% subplot(2,1,2);
hold on;
stem(l20,acfzm20);
xlabel('Lag'); ylabel('Amplitude'); title('Centered and Scaled Sunspot Data ACF for N=20 samples');

%N=250
data_250= data(1,1:250);
data_250_zm=(data_250-(mean(data_250,2)')); %/((std(data_250)'));
[acf250,l250]= xcorr(data_250,'unbiased');
[acfzm250,lz250]= xcorr(data_250_zm,'unbiased');
figure;
% subplot(2,1,1);
stem(l250,acf250);
xlabel('Lag'); ylabel('Amplitude'); title('Sunspot Data ACF for N=250 samples');
% subplot(2,1,2);
hold on;
stem(l250,acfzm250);
hold off;
xlabel('Lag'); ylabel('Amplitude'); title('Centered and Scaled Sunspot Data ACF for N=250 samples');

%PACF
[~,e,rc1]=aryule(data,10);
rc1=-rc1;
norm_data=(data- (mean(data,2))')/(std(data))';
[b,e2,rc2]= aryule(norm_data,10);
rc2=-rc2;
figure;
stem([1:10],rc1);
hold on;
stem([1:10],rc2,'Color','r');
xlabel('Model Order'); ylabel('PACF Amplitude'); title('Sunspot PACF');
legend('data PACF', 'normalised data PACF');
xlim([1 10]);
% subplot(2,1,1);
% stem(rc1);
% title('Partial ACF of Sunspot Series');
% subplot(2,1,2);
% stem(rc2,'Color','g');
% title('Partial ACF of Normalised Sunspot Series');

%Model Order
order=10;
data_norm= zscore(data);
data_norm=data_norm';
N=length(data_norm);
MDL=zeros(order,1);
AIC=zeros(order,1);
AIC_c=zeros(order,1);
error=zeros(order,1);

%Find cumulative squared error
for ind=1:order
    a=aryule(data_norm,ind);
    b= idpoly(a);
    y=predict(b,data_norm);
    error(ind)= (y-data_norm)'*(y-data_norm);
    %AR_mod= filter(1,a,data_norm);
    %error(ind)= (1/N)*(AR_mod-data_norm) * (AR_mod-data_norm)';
%     MDL(1,ind)= log10(error(1,ind))+(1/N)*(ind*log(N));
%     AIC(1,ind)= log10(error(1,ind))+ (2*ind/N); 
end
p=[1:10]';
MDL=log10(error)+ p.*log10(N)./N;
AIC= log10(error)+ 2*p/N;
AICc= AIC + 2.*p.*(p+1)./(N-p-1);

figure('DefaultAxesFontSize',12);
hold on;
plot(p,log10(error));
plot(p,MDL);
plot(p,AIC);
plot(p,AICc);
legend('error','MDL','AIC','AICc');
title('Criteria for Model Order Selection');
xlim([1 10]); ylim([1.6 2]);
xlabel('Model Order'); ylabel('Model Selection Criteria');
hold off;

%Predict
load sunspot.dat
data=sunspot(:,2);
data_norm=zscore(data);


%Predict
m=10; %set prediction step
ar1=aryule(data_norm,1);
ar2=aryule(data_norm,2);
ar10=aryule(data_norm,10);
a1= idpoly(ar1);
a2= idpoly(ar2);
a10=idpoly(ar10);

y1=predict(a1,data_norm,m);
y2= predict(a2,data_norm,m);
y10=predict(a10,data_norm,m);
figure;
subplot(3,1,1);
hold on;
plot(y1,'DisplayName','AR(1)','Color','[1 0.5 0]');
plot(data_norm,'DisplayName','data','Color','blue');
hold off;
title('Prediction for m=10'); xlabel('Sample Index'); ylabel('Amplitude'); legend('Show');
subplot(3,1,2);
hold on;
plot(y2,'DisplayName','AR(2)','Color','[1 0.5 0]');
plot(data_norm, 'DisplayName','data','Color','blue');
hold off;
title('Prediction for m=10'); xlabel('Sample Index'); ylabel('Amplitude'); legend('Show');
subplot(3,1,3);
hold on;
plot(y10,'DisplayName','AR(10)','Color','[1 0.5 0]');
plot(data_norm,'DisplayName','data','Color','blue');
hold off;
title('Prediction for m=10'); xlabel('Sample Index'); ylabel('Amplitude');
legend('Show');


fh = findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 13);