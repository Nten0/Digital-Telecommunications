function [SQNR,Sout]=adm(x,M)

Sin=interp(x,M); %oversampling 
samples=length(Sin); %No. of samples
ss=1/(5*M); %step size initialization

%%%%%%%%%%% ADM ENCODER %%%%%%%%%%%
%ssa: step size array
%enc_signal: coded signal
%ss: step size
[ssa,enc_signal]=adm_encoder(Sin,ss);

%%%%%%%%%%% ADM DECODER %%%%%%%%%%%
%Sout:decoded and reconstructed signal
Sout=adm_decoder(ssa,enc_signal);

%error signal
err_signal=Sin'-Sout;

%SQNR Calculation using the Signal Energy
Pq=sum(err_signal(1:samples).^2)/samples;
Px=sum(Sin(1:samples).^2)/samples;
SQNR=10*log10(Px/Pq); %SQNR in dB