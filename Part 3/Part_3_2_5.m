data = sunspot(:,2);
b=1;
a=[1 0.9];
%theoretical and model-based PSD
[Ry,lags]= xcorr(data,'unbiased');
a1= -(Ry(round(length(lags)/2)))/ Ry(round(length(lags)/2)-1); 
sigma= Ry(round(length(lags)/2)-1)+ a1 * Ry(round(length(lags)/2));
[P_xx, f_xx] = pgm(data);

[h,w]= freqz(b,a,512);
[h2,w2]=freqz([sigma],[1 a1],512);
M=height(w);
figure;
hold on;
plot(w/pi,abs(h).^2);
plot(w/pi,abs(h2).^2,'r');
plot(f_xx/pi,P_xx','Color','[1 0.5 0]');
hold off;
xlabel('Normalised Frequency');
ylabel('PSD'); legend('Exact PSD','Model Based PSD','Periodiogram PSD');
title('Sunspot PSD');
set(gca,'FontSize',14);

[ar1, e1, ~] = aryule(data, 1);
[ar2, e2, ~] = aryule(data, 2);
[ar10, e10, ~] = aryule(data, 10);

[h_1,w_1]=freqz(sqrt(e1),ar1);
[h_2,w_2]=freqz(sqrt(e2),ar2);
[h_10,w_10]=freqz(sqrt(e10),ar10, 144);


figure;
subplot(1,2,1);
hold on;
plot(w_1/(2*pi), abs(h_1).^2, 'linewidth', 1);
plot(w_2/(2*pi), abs(h_2).^2, 'r', 'linewidth', 1);
plot(w_10/(2*pi), abs(h_10).^2,'g', 'linewidth', 1);
plot(f_xx, P_xx, 'Color','[1 0.5 0]','linewidth', 0.90)
hold off;
xlabel('Normalised Frequency');
ylabel('PSD');
set(gca,'FontSize',14);
xlim([0 0.5])
legend('ar1', 'ar2','ar10', 'Periodogram');
title('Sunspot Series');


sunspot_zm=zscore(data);
[ar1, e1, rc1] = aryule(sunspot_zm, 1);
[ar2, e2, rc2] = aryule(sunspot_zm, 2);
[ar10, e10, rc10] = aryule(sunspot_zm, 10);

[h_1,w_ar1]=freqz(sqrt(e1),ar1);
[h_2,w_ar2]=freqz(sqrt(e2),ar2);
[h_10,w_ar10]=freqz(sqrt(e10),ar10, 144);
[P_xx, f_xx] = pgm(sunspot_zm);

subplot(1,2,2)
hold on
plot(w_ar1/(2*pi), abs(h_1).^2, 'linewidth', 1)
plot(w_ar2/(2*pi), abs(h_2).^2, 'r','linewidth', 1)
plot(w_ar10/(2*pi), abs(h_10).^2, 'g','linewidth', 1)
plot(f_xx, P_xx, 'Color','[1 0.5 0]','linewidth', 0.75)
hold off;

xlabel('Normalised Frequency');
ylabel('PSD');
set(gca,'FontSize',14);
xlim([0 0.5])
legend('ar1', 'ar2','ar10', 'Periodogram');
title('Normalised Sunspots');

