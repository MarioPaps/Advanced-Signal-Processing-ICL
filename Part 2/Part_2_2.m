Part_2_1;
%part 2-2
[cross_corr,l]=xcorr(x,y,'unbiased');
stem(l,cross_corr);
xlim([l(980) l(1020)]);
title('CCF of x,y');
xlabel('tau (time lag)'); ylabel('Amplitude');
ylim([-0.1 1.1]);

fh = findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 14);