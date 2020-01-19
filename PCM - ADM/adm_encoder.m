function [StepSizeArray,cn]=adm_encoder(x,StepSize)

%Accumulator initialization
StepSizeArray(1)=StepSize;
%StepSizeArray(2)=StepSize;

if(x(1)>=0) %accum(1) = 0;
    output(1)=1;
    accum(2)=output(1)*StepSizeArray(1);
else
    output(1)=-1;
    accum(2)=output(1)*StepSizeArray(1);
end

%Accumulator implementation
for i=2:length(x)
    if(x(i)>=accum(i))
        output(i)=1;
        if output(i)==output(i-1)
            StepSizeArray(i)=1.5*StepSizeArray(i-1);
        else
            StepSizeArray(i)=(1.5^-1)*StepSizeArray(i-1);
        end
        accum(i+1)=accum(i)+output(i)*StepSizeArray(i);
    else
        output(i)=-1;
        if output(i)==output(i-1)
            StepSizeArray(i)=1.5*StepSizeArray(i-1);
        else
            StepSizeArray(i)=(1.5^-1)*StepSizeArray(i-1);
        end
        accum(i+1)=accum(i)+output(i)*StepSizeArray(i);
    end
end

%encoder
cn=output;
