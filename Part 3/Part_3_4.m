clear
london_num=zeros(1,11);
london_num(1:3)=[0 2 0];
s = RandStream('mlfg6331_64'); %for reproducibility of the results
population=[0:1:9];
for ind=4:length(london_num)
    london_num(ind)= randsample(s,population,1); %produce one random scalar
end
load num_freqs

fsamp=32768;
n=linspace(0,0.25,8192);
y=[];
for ind=1:(length(london_num)-1)
  tempf= (freqs(:, london_num(1,ind)+1));
  f1=tempf(1,1);
  f2=tempf(2,1);
  y1= sin(2*pi*(f1)*n)+sin(2*pi*(f2)*n);
  y2= zeros(1,length(y1));
  y=[y y1 y2];
end
%same procedure for last element
tempf=(freqs(:, london_num(1,11)+1));
f1=tempf(1,1);
f2=tempf(2,1);
y11= sin(2*pi*(f1)*n)+sin(2*pi*(f2)*n);
y=[y y11];

%%%Adding Noise
%adding noise
%noise effects
%  n1= wgn(1,length(y),0.1);
% % n2=wgn(1,length(y),10);
% % n3=wgn(1,length(y),15);
% y=y+n1; %choose which noise vector to add
% %%%Adding Noise

x_ax=linspace(0,5.25,length(y));
figure;
subplot(2,2,1);
plot(x_ax,y);
xlabel('Time(s)'); ylabel('Amplitude'); title('Sequence y');
subplot(2,2,2);
plot(x_ax,y);
xlabel('Time(s)'); ylabel('Amplitude'); title('Subsequent Keys');
xlim([0 0.75]);
cnt=1;
subplot(2,2,3);
plot(n,y(1:length(y1)));
title('Key 0');xlabel('Time(s)'); ylabel('Amplitude');
subplot(2,2,4);
plot(n, y((cnt+1)*length(y1)+1: (cnt+2)*length(y1)));
title('Key 2'); xlabel('Time(s)'); ylabel('Amplitude');


%spectogram
win_length= length(y1);
numoverlap= 0;  
nfft= 8192;
figure;
subplot(2,1,1);
spectrogram(y,hamming(win_length),numoverlap,nfft,fsamp,'yaxis');
title('Spectrogram of y'); ylim([0 3]);
subplot(2,1,2);
[S,f,w]=spectrogram(y,hann(win_length),numoverlap,nfft,fsamp,'yaxis'); 
ylim([0 1.5]); title('Windowed Spectrogram of y');

Y_0= abs(S(:,9));
Y_0= mag2db(Y_0);
Y_2= abs(S(:,11));
Y_2= mag2db(Y_2);
figure;
hold on;
plot(f,Y_0,'DisplayName','key 4');
plot(f,Y_2,'DisplayName','key 7');
hold off; xlabel('Frequency (Hz)'); ylabel('FFT Magnitude');
title('FFT Segments'); legend('Show');
xlim([0 2000]);






fh = findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 14);

