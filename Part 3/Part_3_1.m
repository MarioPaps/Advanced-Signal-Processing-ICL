%input for pgm function
clear 
close all
N=128;
x=randn(1,N);
x1= randn(1,128);
N1=length(x1);
x2= randn(1,256);
N2=length(x2);
x3= randn(1,512);
N3=length(x3);


%pgm tests
f1=[0:(1/N1): (N1-1)/N1];
[Px1]=pgm(x1);
Px1_fir=(1/5)*filter(ones(1,5),1,Px1);
f2=[0:(1/N2): (N2-1)/N2];
[Px2]=pgm(x2);
Px2_fir=(1/5)*filter(ones(1,5),1,Px2);
f3=[0:(1/N3): (N3-1)/N3];
[Px3]=pgm(x3);
Px3_fir=(1/5)*filter(ones(1,5),1,Px3);

figure;
subplot(1,3,1);
plot(f1,Px1);
hold on;
plot(f1,Px1_fir);
legend('original PSD','smoothed PSD');
title('Filtering for N=128');
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD');
subplot(1,3,2);
plot(f2,Px2);
hold on;
plot(f2,Px2_fir);
title('Filtering for N=256'); legend('original PSD','smoothed PSD');
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD');
subplot(1,3,3);
plot(f3,Px3);
hold on;
plot(f3,Px3_fir);
title('Filtering for N=512');
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD');
legend('original PSD','smoothed PSD');

%built-in periodogram
[Pxx,w]= periodogram(x);
figure;
plot(w/pi,Pxx);
title('Periodiogram Power Spectral Density Estimate');
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD');

% my periodiogram
f=[0:(1/N): (N-1)/N];
[Px]=pgm(x);
figure;
plot(f,Px);
title('PSD Estimate');
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD');


%PSD noise estimates
noise=randn(1,1024);
sub=reshape(noise,8,[]); %each row is one sub-array
P=zeros(8,length(noise)/8);
P(1,:)=pgm(sub(1,:));
P(2,:)=pgm(sub(2,:));
P(3,:)= pgm(sub(3,:));
P(4,:)=pgm(sub(4,:));
P(5,:)= pgm(sub(5,:));
P(6,:)= pgm(sub(6,:));
P(7,:)= pgm(sub(7,:));
P(8,:)= pgm(sub(8,:));
K=128; %length of each row

f2=[0:(1/K):(K-1)/K];
figure;
subplot(4,2,1);
plot(f2,P(1,:));
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD'); title('Segment 1 PSD');
subplot(4,2,2);
plot(f2,P(2,:));
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD'); title('Segment 2 PSD');
subplot(4,2,3);
plot(f2,P(3,:));
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD'); title('Segment 3 PSD');
subplot(4,2,4);
plot(f2, P(4,:));
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD'); title('Segment 4 PSD');
subplot(4,2,5);
plot(f2, P(5,:));
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD'); title('Segment 5 PSD');
subplot(4,2,6);
plot(f2,P(6,:));
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD'); title('Segment 6 PSD');
subplot(4,2,7);
plot(f2,P(7,:));
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD'); title('Segment 7 PSD');
subplot(4,2,8);
plot(f2,P(8,:));
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD'); title('Segment 8 PSD');

sgtitle('PSD of 8 Segments') 

%averaged periodiogram
P_mean=mean(P,1);
figure;
plot(f2,P_mean);
xlabel('Normalised Frequency (2\pi rads/sample)'); ylabel('PSD'); 
title('Averaged Periodogram');

fh = findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 13);
