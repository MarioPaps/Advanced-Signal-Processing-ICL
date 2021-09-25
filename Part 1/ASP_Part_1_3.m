%each section should be run after commenting out the other sections
%part 1-3-1 Gaussian pdf estimate
N=10000; %sample length
v=randn(1,N); 
pdf;

%part 1-3-2 uniform random process estimate
M=100;
N=10000;
v=rp3(M,N);
pdf;

%part 1-3-1 signal whose mean changes from 0 to 1 after 500 samples
a1=rand(500,1)-0.5;
a2=rand(500,1)+0.5;
a=[a1' a2'];
subplot(2,1,1);
stem(a);
xlabel('n');ylabel('a[n]'); title('Non-Stationary Signal');
subplot(2,1,2);
hist_a=histogram(a,'Normalization','pdf');
xlabel('x[n]'); ylabel('Relative Frequency');
