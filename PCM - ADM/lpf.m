function Sa=lpf(tap,cf,Sn)
%LPF lowpass filter
%tap: filter order.
%cf: cut-off frequency.
%Sn: quantized signal.
%Sa: decoder output.
  
b=fir1(tap,cf);
Sa=conv2(Sn,b,'same');