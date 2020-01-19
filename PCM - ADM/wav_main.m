%Load speech signal
[y,fs]=audioread('speech.wav');
Sin=y;

%Line Plot of audio signal
y=y(:,1);
dt=1/fs;
t=0:dt:(length(y)*dt)-dt;
figure(1)
plot(t,y); xlabel('Seconds'); ylabel('Amplitude');
title('Line Plot of Input audio signal')
    
%normalize signal between [xmin,xmax] = [-1,1]
y=(y-min(y));
m=(min(y)+max(y))/2;
speech_signal=(y-m)/m;

%call Lloyd-Max algorith for 2,4 and 8 bits 
for i=1:3
    [xq,centers,D]=lloyd_max(speech_signal,2^i,-1,1);
    
    SQNR_PCM=zeros(length(D),1);
    for k=1:length(D)
        SQNR_PCM(k)=10*log10(mean(speech_signal.^2)/D(k)); %SQNR in dB
    end
    
    %Plot kmax-SQNR
    kmax=[1:1:length(D)];
    figure(i*2)
    plot(kmax,SQNR_PCM,'--'); xlabel('kmax'); ylabel('SQNR');
    title(strcat(num2str(2^i),'-bit quantizer'))
    legend(strcat('kmax gia ',num2str(2^i),' bits'),'SQNR');
    
    %Line Plot of quantized audio signal
    figure(i*2+1)
    plot(t,xq); xlabel('Seconds'); ylabel('Amplitude');
    title(strcat('Line Plot of quantized audio signal with a ',num2str(2^i),'-bit quantizer'))
    
    %Calculate Entropy
    y=tabulate(xq); %[Value | Count | Percent]
    prob=y(:,3);
    %[tmp(:,1) prob] %print [Value | Percent]
    prob=prob./100;
    entropy(i)= -sum(prob.*log2(prob));
end


%%%%%%%%%%% ADM %%%%%%%%%%%
M=128;

%call ADM
[SQNR_ADM,adm_out]= adm(Sin,M);
    
%Plot of ADM output audio signal
dt=1/(fs*M);
t=0:dt:(length(adm_out)*dt)-dt;
figure((i+1)*2)
plot(t,adm_out); xlabel('Seconds'); ylabel('Amplitude');
title(strcat('Line Plot of ADM output ( ', num2str(M),')' ));