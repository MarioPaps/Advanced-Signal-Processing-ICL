%each section should be run after commenting out the other sections
part 1.3.1
hist=histogram(v,'Normalization','Probability');
title('Input Samples Histogram');
hold on;
probs=hist.Values ;%y-axis probabilities
rv_values=hist.BinEdges;

intervals=zeros(length(rv_values)-1,2);
for index=1:(length(rv_values)-1)
    intervals(index,1)= rv_values(1,index);
    intervals(index,2)= rv_values(1,index+1);
 end
x_ax=(mean(intervals,2))';
plot(x_ax,probs,'Color','Red');
title('PDF Estimate');
legend('Histogram bin','Approximate pdf');
low=x_ax(1)-1; high=x_ax(length(x_ax))+1; 
xlim([low high]);
xlabel('x'); ylabel('Probability');

%part 1.3.2
hist_rp=histogram(v,'Normalization','pdf'); 
title('rp3 Histogram');
rel_freqs=hist_rp.Values ;%y-axis probabilities
num=hist_rp.NumBins;  
data_vals=hist_rp.BinEdges;

ints=zeros(length(rel_freqs)-1,2);
for id=1:(length(data_vals)-1)
    ints(id,1)=data_vals(1,id);
    ints(id,2)=data_vals(1,id+1);
end
x=(mean(ints,2))';
low=x(1)-0.5; high=x(length(x))+0.5; 
figure;
subplot(2,1,1);
plot(x,rel_freqs);
title('rp3 PDF Estimate');
xlabel('x'); ylabel('Probability');
xlim([low high]);
ylim([0.1 0.5]);
subplot(2,1,2);
pd_th=repelem((1/abs(data_vals(length(data_vals))- data_vals(1))),length(x));
plot(x,pd_th,'Color','Red');
xlim([low high]);
ylim([0.2 0.4]);
title('rp3 Theoretical PDF');
xlabel('x'); ylabel('Probability');
