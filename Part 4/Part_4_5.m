clear
close all
fs1 = 44100;

in_a=audioinfo('a1m.wav');
[a_rec,fr_a]= audioread('a1m.wav');
a=a_rec(13000:13999);
a_new= a';

mu=0.6;
ord=10;
[ya,err_a,ev_a]=ar_speech(a_new,mu,ord);

figure;
for ind=1:width(ev_a)
    hold on;
    plot(ev_a(:,ind),'DisplayName',num2str(ind));
end
hold off; legend('show');
xlabel('Iteration Number'); ylabel('Amplitude'); title('Coefficients Evolution for "a" ');

%letter e
in_e=audioinfo('e1.wav');
[e_rec,fr_e]= audioread('e1.wav');
e=e_rec(29000:31750);
[e_h,e_l]= rat(fs1/fr_e);
e_new=resample(e,e_h,e_l);
e_new= e_new';

mu=5;
ord=10;
[ye,err_e,ev_e]=ar_speech(e,mu,ord);

figure;
for ind=1:width(ev_e)
    hold on;
    plot(ev_e(:,ind),'DisplayName',num2str(ind));
    xlim([1 1000]);
end
hold off; legend('show');
xlabel('Iteration Number'); ylabel('Amplitude'); title('Coefficients Evolution for "e" ');


% %letter s
in_s=audioinfo('S.wav');
[s_rec,fr_s]= audioread('S.wav');
s=s_rec(31000:32000);
[s_h,s_l]= rat(fs1/fr_s);
s_new=resample(s,s_h,s_l);
s_new= s_new';
mu=0.5;
ord=10;
[ys,err_s,ev_s]=ar_speech(s_new,mu,ord);

figure;
for ind=1:width(ev_s)
    hold on;
    plot(ev_s(:,ind),'DisplayName',num2str(ind));
end
hold off; legend('show');
xlabel('Iteration Number'); ylabel('Amplitude'); title('Coefficients Evolution for "s" ');


% %letter t
in_t=audioinfo('T.wav');
[t_rec,fr_t]= audioread('T.wav');
t=t_rec(31000:32000);
[t_h,t_l]= rat(fs1/fr_t);
t_new=resample(t,t_h,t_l);
t_new= t_new';
mu=0.5;
ord=10;
[yt,err_t,ev_t]=ar_speech(t_new,mu,ord);

figure;
for ind=1:width(ev_t)
    hold on;
    plot(ev_t(:,ind),'DisplayName',num2str(ind));
end
hold off; legend('show');
xlabel('Iteration Number'); ylabel('Amplitude'); title('Coefficients Evolution for "t" ');

% %letter x
in_x=audioinfo('X.wav');
[x_rec,fr_x]= audioread('X.wav');
x=x_rec(31000:34000);
[x_h,x_l]= rat(fs1/fr_x);
x_new=resample(x,x_h,x_l);
x_new= x_new';
mu=0.05;
ord=6;
[yx,err_x,ev_x]=ar_speech(x_new,mu,ord);

figure;
for ind=1:width(ev_x)
    hold on;
    plot(ev_x(:,ind),'DisplayName',num2str(ind));
    xlim([1 1000]);
end
hold off; legend('show');
xlabel('Iteration Number'); ylabel('Amplitude'); title('Coefficients Evolution for "x" ');


%%MDL, AIC sketching
%set sunspot to a specific column vector corresponding to audio file
audio_in= a;
N= length(audio_in);
e = zeros(1,ord);
MDL = zeros(1,ord);
AIC = zeros(1,ord);
AICC = zeros(1,ord);
x = linspace(1, ord, ord);

for i = 1:ord
    a = aryule(audio_in, i);
    b=idpoly(a);
    y=predict(b,audio_in);
    e(1,i)= (1/N) * (y-audio_in)' * (y-audio_in);
    MDL(1,i) = log(e( 1,i)) + (i * log(N)) / N;
    AIC(1, i) = log(e(1,i)) + ((2 * i) / N);
end
    figure;
    hold on;
    plot(x, MDL,'-o','DisplayName','Minimum description length (MDL)');
    plot(x, AIC,'-o','DisplayName','Akaike information criterion (AIC)');
    legend('show');
    hold off
    title('Model Order Selection (MDL,AIC,AIC_C)','FontSize',18);
    xlabel('Model Order','FontSize',18);
    ylabel('Prediction Error','FontSize',18);
    
%%prediction gain calculations
ord=10;
rp=zeros(1,ord);
for i = 1:ord
    a = aryule(audio_in, i);
    b=idpoly(a);
    y=predict(b,audio_in);
    e(1,i)= (1/N) * (y-audio_in)' * (y-audio_in);
    rp(1,i) = 10*log10((std(audio_in)^2)/(std(e(1,i)^2)));
end
