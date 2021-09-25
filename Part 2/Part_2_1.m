%part 2-1
x=randn(1,1000);
[acf_x,lags]=xcorr(x,'unbiased');
stem(lags,acf_x);
xlim([lags(1) lags(length(lags))]); %lags are offset by 1,000 acf[-999] corresponds to acf[1] in matlab
xlabel('tau (time lag)'); ylabel('Amplitude'); title('Unbiased 1000-sample ACF');
figure;
subplot(2,1,1);
stem(lags,acf_x);
xlim([lags(950) lags(1050)]);
xlabel('tau (time lag)'); ylabel('Amplitude'); title('ACF for |tau|<50');
subplot(2,1,2);
stem(lags,acf_x);
xlim([lags(1990) lags(1999)]);
xlabel('tau (time lag)'); ylabel('Amplitude'); title('ACF for large |tau|');
%MA process
y=filter(ones(3,1),[1],x);
[acf_y,lgs]=xcorr(y,'unbiased');
figure;
stem(lgs,acf_y);
xlim([-20 20]);
xlabel('tau (time lag)'); ylabel('Amplitude'); title('ACF of MA(9) Filter');


fh = findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 14);





