clc
close all
N=1064;
x=randn(1,N);
b=1;
a=[1 0.9];
y=filter(b,a,x);
y_mod=y(41:length(y));
figure;
subplot(2,1,1);
set(gca,'FontSize',11);
plot(x);
xlabel('Sample Index'); ylabel('Amplitude'); title('Signal x');
subplot(2,1,2);
plot(y,'Color',[1 0.5 0]);
xlabel('Sample Index'); ylabel('Amplitude'); title('Signal y');

%PSD plot
[h,w]= freqz(b,a,512);
M=height(w);
figure;
set(gca,'FontSize',12);
Py= pgm(y_mod);
Py=(Py(1:M))';
subplot(2,1,1);
hold on;
plot(w/(2*pi),abs(h).^2);
plot(w/(2*pi),Py,'Color',[1 0 0]);
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD');
title('AR(1) Process PSD ');
legend('Exact PSD','Periodogram PSD Estimate');
hold off;
%zoomed PSD plot
subplot(2,1,2);
set(gca,'FontSize',12);
plot(w/(2*pi),abs(h).^2);
hold on;
plot(w/(2*pi),Py,'Color',[1 0 0]);
xlim([0.4 0.5]);
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD');
title('Zoomed-in AR(1)Process PSD');
legend('Exact PSD','Periodogram PSD Estimate');
hold off;

%use xcorr %the windowing function is a sinc in freq domain which causes
%the oscillations
[Ry,lags]= xcorr(y_mod,'unbiased');
a1= -(Ry(1025)/ Ry(1024)); 
sigma= Ry(1024)+ a1 * Ry(1025);
%generate Pyf with freqz
[h2,w2]=freqz([sigma],[1 a1],512);
figure;
subplot(1,2,1);
hold on;
plot(w2/(2*pi),abs(h).^2,'LineWidth',2);
plot(w2/(2*pi),abs(h2).^2,'g','LineWidth',2);
plot(w2/(2*pi),Py,'Color',[1 0.5 0],'LineWidth',1);
legend('Exact PSD','Model Based PSD','Periodiogram PSD');
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD');
title('Model-based PSD'); 
hold off;
subplot(1,2,2);
hold on;
plot(w2/(2*pi),abs(h).^2,'LineWidth',2);
plot(w2/(2*pi),abs(h2).^2,'g','LineWidth',2);
plot(w2/(2*pi),Py,'Color',[1 0.5 0],'LineWidth',1);
legend('Exact PSD','Model Based PSD','Periodiogram PSD');
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD');
title('Model-based PSD'); xlim([0.4 0.5]);
hold off;

fh = findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 13);


