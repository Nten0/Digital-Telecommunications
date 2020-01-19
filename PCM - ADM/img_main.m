%Load 2d-image 
load cameraman.mat
figure(1)
imshow(uint8(i));
title('Input Image')

%Convert image from 2d in 1d and normalize it between [xmin,xmax] = [-1,1]
img_signal_1d=i(:);
img_signal_1d=(img_signal_1d-128)/128;

%Call Lloyd-Max algorith for 2 and 4 bits 
for i=1:2
    [xq,centers,D]=lloyd_max(img_signal_1d,2*i,-1,1);
    
    %Reshape quantized image in 2d and plot it
    figure(i*2)
    p=128*xq+128;
    y=reshape(p,256,256);
    imshow(uint8(y));
    title(strcat('Image with ',num2str(2^i),'-bit quantizer'))
    
    SQNR=zeros(length(D),1);
    for k=1:length(D)
        SQNR(k)=10*log10(mean(img_signal_1d.^2)/D(k)); %SQNR in dB
    end
    
    %Plot kmax-SQNR
    kmax=[1:1:length(D)];
    figure(i*2+1)
    plot(kmax,SQNR,'--'); xlabel('kmax'); ylabel('SQNR');
    title(strcat(num2str(2*i),'-bit quantizer'))
    legend(strcat('kmax gia ',num2str(2*i),' bits'),'SQNR');  
    
    %Calculate Entropy
    tmp=tabulate(xq); %[Value | Count | Percent]
    prob=tmp(:,3);
    %[tmp(:,1) prob] %print [Value | Percent]
    prob=prob./100;
    entropy(i)= -sum(prob.*log2(prob))
end