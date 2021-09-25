%adding noise to y
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

%noise effects
n1= wgn(1,length(y),0.1);
n2=wgn(1,length(y),1);
n3=wgn(1,length(y),10);
%y=y+n2; %choose which noise vector to add

cnt=1;
subplot(2,1,1);
plot(n,y(1:length(y1)));
title('Key 0');xlabel('time(s)'); ylabel('Amplitude');
xlim([0 0.015]);
subplot(2,1,2);
plot(n, y((cnt+1)*length(y1)+1: (cnt+2)*length(y1)));
title('Key 2'); xlabel('Time(s)'); ylabel('Amplitude');
x_ax=linspace(0,5.25,length(y));
figure;
plot(x_ax,y);
xlabel('time(s)'); ylabel('Amplitude'); title('Sequence y Plot');

%spectogram
win_length= length(y1);
numoverlap= 0;  
nfft= 8192;
[s,f,t]=spectrogram(y,hann(win_length),numoverlap,nfft,fsamp,'yaxis'); 
figure;
spectrogram(y,hann(win_length),numoverlap,nfft,fsamp,'yaxis');
ylim([0 1.5]); title('Spectrogram of y');
% figure;
% plot(s(:,3));

fh = findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 12);

