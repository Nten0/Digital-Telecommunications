%Load random signal
fs=8000;
rng('default') %for reproducibility
y = normrnd(-0.04,sqrt(0.11),[39921,1]);
Sin=y;

%Line Plot of audio signal
y=y(:,1);
dt=1/fs;
t=0:dt:(length(y)*dt)-dt;
figure(1)
plot(t,y); xlabel('Seconds'); ylabel('Amplitude');
title('Line Plot of Input random signal')
   
%normalize signal between [xmin,xmax] = [-1,1]
y=(y-min(y));
m=(min(y)+max(y))/2;
speech_signal=(y-m)/m;

%call Lloyd-Max algorith for 2 bits 
[xq,centers,D]=lloyd_max(speech_signal,2,-1,1);

SQNR_PCM=zeros(length(D),1);
for k=1:length(D)
    SQNR_PCM(k)=10*log10(mean(speech_signal.^2)/D(k)); %SQNR in dB
end

%Plot kmax-SQNR
kmax=[1:1:length(D)];
figure(2)
plot(kmax,SQNR_PCM,'--'); xlabel('kmax'); ylabel('SQNR');
title(strcat(num2str(2),'-bit quantizer'))
legend(strcat('kmax gia ',num2str(2),' bits'),'SQNR');