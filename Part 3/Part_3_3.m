clear
load sunspot.dat
x=(sunspot(:,2)); %input data
data=x;
x=(x-mean(x));
[rxx,lags]= xcorr(x,'biased');
rxx_pos= rxx(round(length(rxx)/2)+1: length(rxx));
in=randn(length(x),1);

N=length(x);
M=height(rxx);
start=round(M/2); %288
sth=rxx(start:end);
a_p=zeros(2,1);
E_p=zeros(1,10);
a_ls=zeros(10,10);

for p=1:10
    H=zeros(start-1,p);
    for ind=1:p
        h=rxx(start-(ind-1): M-(ind));
        H(:,ind)=h;
    end
a_p= inv(transpose(H)*H)* transpose(H)*rxx_pos;
a_ls(p,1:p)= a_p';
est= H *a_ls(p,1:p)'; %approximated signal
if(p==3)
    estim=est;
end
E_p(p)= (1/(start-1))* (rxx_pos-est)'*(rxx_pos-est);
end
%approximation error
figure;
plot(estim,'DisplayName','AR(3) model','Color','[1 0.5 0]');
hold on;
plot(data,'DisplayName','zero-mean sunspot data','Color','b'); legend('show');
hold off;
xlabel('Time Index'); ylabel('Amplitude'); title('Sunspot Series and AR(3) Model');


p = (1:10);
MDL = log10(E_p) + p.*log10(N)./N;
AIC = log10(E_p) + 2*p/N;
AICc = AIC + 2.*p.*(p+1)./(N - p - 1);

% Plot results-we get negative values bc it's cumulative square error
figure;
subplot(1,2,1);
hold on;
plot(p, MDL, 'b-', 'LineWidth', 1,'DisplayName','MDL');
plot(p, AIC, 'r-', 'LineWidth', 1,'DisplayName','AIC');
plot(p, AICc, 'g-', 'LineWidth', 1,'DisplayName','AICc');
xticks(1:1:10);
hold off; legend('show');
xlabel('Model Order'); ylabel('Value');
title('Model Order Selection Criteria');

subplot(1,2,2);
plot(p,(E_p));
xlabel('Model Order'); ylabel('Error Amplitude'); xticks(1:1:10);
title('Mean Squared Error');

%power spectra
%using a values we got, we can estimate the psd
a_p = [ones(10,1) -a_ls];
[a1, e1, r1] = aryule(x, 1);
[a2, e2, r2] = aryule(x, 2);
[a3,e3,r3]= aryule(x,3);
[a10, e10, r10] = aryule(x, 10);

[h1,w1]=freqz(sqrt(e1),a_p(1, 1:2));
[h2,w2]=freqz(sqrt(e2),a_p(2, 1:3));
[h3,w3]= freqz(sqrt(e3),a_p(3, 1:4));
[h10,w10]=freqz(sqrt(e10),a_p(10, 1:11));
[P_xx, f_xx] = pgm(x);

figure; %we get good PSD with the M susshi uses M=75
hold on;
plot(w1/(2*pi), abs(h1).^2, 'linewidth', 1);
plot(w2/(2*pi), abs(h2).^2, 'linewidth', 1);
plot(w3/(2*pi), abs(h3).^2, 'linewidth', 1);
plot(w10/(2*pi), abs(h10).^2, 'linewidth', 1);
plot(f_xx, P_xx,'linewidth', 1.5);
hold off;

xlabel('Normalised Frequency (2\pi rads/sample)');
ylabel('PSD'); title('Sunspot Series Power Spectra');
set(gca,'FontSize',15);
xlim([0 0.5])
legend('AR(1)', 'AR(2)','AR(3)','AR(10)', 'Periodogram');

%3.3.6 ->plot for MSE vs N- code does not compile ->needs to be fixed
load sunspot.dat
% data = sunspot(:,2);
% norm_data= zscore(data);
% a = zeros(10,10);
% 
% mse = zeros(1,10);
% err = zeros(1,10);
% plot_corr = xcorr(norm_data, 'biased');
% 
% N=[10:5:250];
% for ind=1:length(N)
%     L= N(ind)-1;
%     ord=3;
%     data_res= norm_data(1:N(ind));
%     [r,lags]= xcorr(data_res, 'biased');
%     [~, k]= max(r);
%     rest=r(k:(k+L-1));
%     H=zeros(L,ord);
%     for v=1:L
%         for n=1:L
%             H(k,n)=r(v-n+k)/r(k);
%         end
%     end
%     
%     a_ls = inv(H'*H)*H'*rest;
%     a_ls(ord,1:ord)=a_ls';
%     est= H* a_ls(ord,1:ord)';
%     err((N(ind)/5)-1)= (1/L) * (r(k+1:k+L)-est)' * (r(k+1:k+L)-est);
% end
% figure;
% v= 10:5:250;
% plot(v,err);
% xlabel('N'); ylabel('Amplitude'); title('MSE versus N');







fh= findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 14)





















