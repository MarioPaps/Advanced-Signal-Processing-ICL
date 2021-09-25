function [Px,freq]= pgm(x)
 M= length(x);
% for ind=1:M
%     sum=0;
%     for n=1:M
%         sum=sum+(x(1,n)*exp(-1i*2*pi*f(ind)*(n)));
%     end
%     Px(ind)=(1/M)*((abs(sum))^2);
% end

xdft=fft(x);
Px= (1/M).*(abs(xdft).^2);
freq=[0: (1/M):(M-1)/M];


end