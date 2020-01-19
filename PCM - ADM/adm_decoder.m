function [Sout]=adm_decoder(StepSizeArray,cn)

%decoder and accumulator
output(1)=0;

for i=1:length(cn)
   if(cn(i)==1)
      output(i+1)=output(i)+StepSizeArray(i);
  elseif (cn(i)==-1)
      output(i+1)=output(i)-StepSizeArray(i);
   end
end

%Quantized output
dec_signal=output(2:length(cn)+1);

%Quantized reconstructed signal.
Sout=lpf(100,.1,dec_signal); %low pass filter to reduce noise
end
