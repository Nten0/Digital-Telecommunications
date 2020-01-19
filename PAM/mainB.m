Tsample=1;
Tc=4;
fc=1/Tc;
Tsymbol=40;
Lb = 100002;
z=0;

for SNR=0:2:20
    %Mapper
    in=mapper(input,M,gray);
    
    %rectangular pulse
    g=sqrt(2/Tsymbol);

    %M-PAM modulation
    A=1/sqrt(M+1);
    for m=0:M-1
        s(m+1)=(2*m-1-M)*A;
    end

    for i=1:length(in)
        for t=1:Tsymbol
            signal(i,t)=s(in(i)+1)*g*cos(2*pi*fc*t);
        end
    end

    %AWGN
    sigma_sq=(1/log2(M))/(2*10^(SNR/10)); %ó^2
    noise=sqrt(sigma_sq)*randn(Lb/log2(M),Tsymbol); %Gaussian noise

    send=signal+noise;

    %M-PAM demodulation
    for t=1:Tsymbol
        y(t)=g*cos(2*pi*fc*t);
    end
    r=send*y';

    %Envelope Detector
    for i=1:length(r)
        for j=1:M
            temp(i,j)=norm(r(i)-s(j));
        end
        s_h(i)=min(temp(i,:));
        for j=1:M
            if s_h(i)==temp(i,j)
                s_hat(i)=j-1;
            end
        end
    end
    
    %Demapper
    output=demapper(s_hat,M,gray);
    
    z=z+1;
    %BER calculation
    b_errors=0;
    for i=1:length(output)
        if output(i)~=input(i)
            b_errors=b_errors +1 ;
        end
    end
    BER(z)=b_errors/length(input);
    
    %SER calculation
    s_errors=0;
    for i=1:length(s_hat)
        if s_hat(i)~=in(i)
            s_errors=s_errors +1 ;
        end
    end
    SER(z)=s_errors/length(in);
end