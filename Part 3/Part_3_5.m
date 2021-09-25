clear
close all
load RAW-ECG.mat
load RRI-DATA.mat
fs=4; %sampling frequency of given data
c50=fs*50;
c150=fs*150;

xRRI= xRRI1; %pick trial ->set to xRRI1,xRRI2,xRRRI3
mean(xRRI3)
xRRI= detrend(xRRI);
Px=pgm(xRRI);
freqs=linspace(0,1,length(Px));
figure;
subplot(1,3,1);
plot(freqs(1:length(freqs)/2), Px(1:length(Px)/2));
xlim([0 0.5]);
title('Trial 1 Average Periodogram'); xlabel('Normalised Frequency'); ylabel('PSD');

win_sz50=floor(length(xRRI)/c50);
pxx50=zeros(1,c50);

for ind=0:win_sz50-1
    x_avg_50= xRRI(ind*c50+1:(ind+1)*c50);
    pxx50=pxx50+ pgm(x_avg_50);
end
pxx50= pxx50./win_sz50;
pxx_avg50= (pxx50);
freqs=linspace(0,1,length(pxx_avg50));
subplot(1,3,2);
plot(freqs(1:length(freqs)/2), pxx_avg50(1:length(pxx_avg50)/2));
xlim([0 0.5]);
title('Trial 1 50s Window'); xlabel('Normalised Frequency'); ylabel('PSD');


Px=pgm(xRRI);

win_sz150=floor(length(xRRI)/c150);
pxx150=zeros(1,c150);

for ind=0:win_sz150-1
    x_avg_150= xRRI(ind*c150+1:(ind+1)*c150);
    pxx150=pxx150+ pgm(x_avg_150);
end
pxx150= pxx150./win_sz150;
pxx_avg150= (pxx150);
freqs=linspace(0,1,length(pxx_avg150));
subplot(1,3,3);
plot(freqs(1:length(freqs)/2), pxx_avg150(1:length(pxx_avg150)/2));
xlim([0 0.5]);
title('Trial 1 150s Window'); xlabel('Normalised Frequency'); ylabel('PSD');


%optimise code for plotting
fh= findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 12);

[Px1,f1]= pgm(xRRI1);




