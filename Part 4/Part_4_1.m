clear
N=1000;
x=randn(N,1);
b=[1,2,3,2,1];
a=[1];
y= filter(b,a,x);
% y=zscore(y);  %if I don;t normalise, the coefficients are close to b
heta= 0.01* randn(N,1); %std*randn()+ mean
z=heta+y;

SNR= ((1/height(z))* sum(z.^2))/(var(heta));
SNR_db= 10*log10(SNR);

Nw=length(b);
[pzx,l1]= xcorr(z,x,'unbiased'); %1000 is lag 0
[rxx,l2]= xcorr(x,'unbiased');
start=round(length(l1)/2);
Pzx= pzx(start:start+Nw-1);
Rxx=zeros(Nw,Nw);
rxx=rxx';
for ind=1:Nw
    r= rxx(start-(ind-1):1:start+Nw-ind);
    Rxx(:,ind)= r';
end
wopt=( Rxx\Pzx)';

%repeat with 6 different variances
Nw=5;
vars=[0.1,1,3,6,9,10];
heta_v= sqrt(vars(6)) * randn(N,1);
z_v= heta_v+y;

SNR_v= ((1/height(z))* sum(z_v.^2))/(var(heta_v));
SNR_v_db= 10*log10(SNR_v);
pzx_v= xcorr(z_v,x,'unbiased'); %1000 is lag 0
Pzx_v= pzx_v(start:start+Nw-1);
Rxx_v=zeros(Nw,Nw);

for ind=1:Nw
    r_v= rxx(start-(ind-1):1:start+Nw-ind);
    Rxx_v(:,ind)= r_v';
end
wopt_v=( Rxx_v\Pzx_v)';  %higher noise variance results in larger w_opt

%what happens if Nw>4 =>Nw=7, the coefficients go close to 0