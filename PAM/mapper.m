function [y] = mapper(x,M,gray)
k = 1;
if gray == 0 %Simple encoding
    if M == 4
        for i = 1:2:length(x)
            if x(i) == 0 && x(i+1) == 0
                y(k) = 0;
            elseif x(i) == 0 && x(i+1) == 1
                y(k) = 1;
            elseif x(i) == 1 && x(i+1) == 0
                y(k) = 2;
            elseif x(i) == 1 && x(i+1) == 1
                y(k) = 3;
            end
            k = k+1 ;
        end
    elseif M == 8
        for i = 1:3:length(x)
            if x(i) == 0 && x(i+1) == 0 && x(i+2) == 0
                y(k) = 0;
            elseif x(i) == 0 && x(i+1) == 0 && x(i+2) == 1
                y(k) = 1;
            elseif x(i) == 0 && x(i+1) == 1 && x(i+2) == 0
                y(k) = 2;
            elseif x(i) == 0 && x(i+1) == 1 && x(i+2) == 1
                y(k) = 3;
            elseif x(i) == 1 && x(i+1) == 0 && x(i+2) == 0
                y(k) = 4;
            elseif x(i) == 1 && x(i+1) == 0 && x(i+2) == 1
                y(k) = 5;
            elseif x(i) == 1 && x(i+1) == 1 && x(i+2) == 0
                y(k) = 6;
            elseif x(i) == 1 && x(i+1) == 1 && x(i+2) == 1
                y(k) = 7;
            end
            k = k+1;
        end
    end
elseif gray == 1 %Gray code
    if M == 4
        for i = 1:2:length(x)
            if x(i) == 0 && x(i+1) == 0
                y(k) = 0;
            elseif x(i) == 0 && x(i+1) == 1
                y(k) = 1;
            elseif x(i) == 1 && x(i+1) == 1
                y(k) = 2;
            elseif x(i) == 1 && x(i+1) == 0
                y(k) = 3;
            end
            k = k+1 ;
        end
    elseif M == 8
        for i = 1:3:length(x)
            if x(i) == 0 && x(i+1) == 0 && x(i+2) == 0
                y(k) = 0; 
            elseif x(i) == 0 && x(i+1) == 0 && x(i+2) == 1
                y(k) = 1;
            elseif x(i) == 0 && x(i+1) == 1 && x(i+2) == 1
                y(k) = 2;
            elseif x(i) == 0 && x(i+1) == 1 && x(i+2) == 0
                y(k) = 3;
            elseif x(i) == 1 && x(i+1) == 1 && x(i+2) == 0
                y(k) = 4;
            elseif x(i) == 1 && x(i+1) == 1 && x(i+2) == 1
                y(k) = 5;
            elseif x(i) == 1 && x(i+1) == 0 && x(i+2) == 1
                y(k) = 6;
            elseif x(i) == 1 && x(i+1) == 0 && x(i+2) == 0
                y(k) = 7;
            end
            k = k+1;
        end
    end        
end