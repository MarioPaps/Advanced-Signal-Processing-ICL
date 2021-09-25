M=100;
N=100;
out1=rp1(M,N);
ensemble_avg1=mean(out1); %take the average across each column which an RV
ensemble_std1=sqrt(var(out1));

out2=rp2(M,N);
ensemble_avg2=mean(out2);
ensemble_std2=sqrt(var(out2));
rep_av2=mean(ensemble_avg2,2); %check what value the mean converges to 
rep_std2=mean(ensemble_std2,2);

out3=rp3(M,N);
ensemble_avg3=mean(out3);
ensemble_std3=sqrt(var(out3));
rep_av3=mean(ensemble_avg3,2);%check what value the mean converges to 
rep_std3=mean(ensemble_std3 ,2 );

%plot ensemble average and std of each process
time=[0:1:99];
figure(1)
subplot(2,1,1);
plot(time,ensemble_avg1,'Color','Blue');
xlabel('Time'); ylabel('Mean'); title('rp1');
subplot(2,1,2);
plot(time, ensemble_std1,'Color','Green');
xlabel('Time'); ylabel('Standard Deviation');

figure(2)
subplot(2,1,1);
plot(time,ensemble_avg2,'Color','Blue'); 
xlabel('Time'); ylabel('Mean'); title('rp2');
subplot(2,1,2);
plot(time,ensemble_std2,'Color','Green');
xlabel('Time'); ylabel('Standard Deviation');

figure(3)
subplot(2,1,1);
plot(time,ensemble_avg3,'Color','Blue'); 
xlabel('Time'); ylabel('Mean'); title('rp3');
subplot(2,1,2);
plot(time,ensemble_std3,'Color','Green');
xlabel('Time'); ylabel('Standard Deviation');

%4 realisations of 1000 samples for each process

 mat2=rp2(4,1000);
 time_avg2=(mean(mat2,2))';
 time_std2=(std(mat2,[],2))';
 
 mat3=rp3(4,1000);
 time_avg3=(mean(mat3,2))';
 time_std3=(std(mat3,[],2))';
 
fh = findall(0,'Type','Figure');
set( findall(fh, '-property', 'fontsize'), 'fontsize', 13);

