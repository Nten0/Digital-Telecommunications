function [xq,centers,D] = lloyd_max(x,N,xmin,xmax)
    levels=2^N;
    delta=(xmax-xmin)/levels;
    upperBound=[];
    lowerBound=[];
    c=xmin;

    %Create uniformly span (isapexonta diasthmata)
    while c<xmax
        lowerBound=[lowerBound c];
        upperBound=[upperBound c+delta];
        c=c+delta;
    end

    %Calculate centroids
    span=cell(1,length(lowerBound));
    centers=zeros(1,length(lowerBound));
    for i=1:length(lowerBound)
        span{i}=[lowerBound(i) upperBound(i)];
        centers(i)=mean(span{i});
    end
    
    %Calculate quantized signal based on the centroids
    D=[0];
    xq=zeros(length(x),1);
    for k=1:length(span)
        s=span{k};
        for i=1:length(x)
            if (x(i)>=s(length(s)-1))&&(x(i)<s(length(s)))  
                xq(i)=centers(k);
            end
            if x(i)<=xmin
                xq(i)=centers(1);
            end
            if x(i)>=xmax 
                xq(i)=centers(length(centers));  
            end
        end   
    end
    D=[D mean((x-xq).^2)];
    
    %Recalculate until we reach the desire limit
    count=2;
    while abs(D(count)-D(count-1))>=eps
        tmp=[];
        for i=1:length(centers)-1
            tmp=[tmp (centers(i)+centers(i+1))/2];
        end
        spaces=[xmin,[tmp],xmax];
        for i=1:length(spaces)-1
            span{i}=[spaces(i) spaces(i+1)];
        end
        for i=1:length(spaces)-1
            centers(i)=mean(x(x>=spaces(i) & x<=spaces(i+1)));
        end
        xq=zeros(length(x),1);
        for k=1:length(span)
            s=span{k};
            for i=1:length(x)
                if (x(i)>=s(length(s)-1))&&(x(i)<s(length(s)))  
                    xq(i)=centers(k);
                end
                if x(i)<=xmin
                    xq(i)=centers(1);
                end
                if x(i)>=xmax 
                    xq(i)=centers(length(centers));  
                end
            end   
        end
        D=[D mean((x-xq).^2)];
        count=count+1;
    end
end