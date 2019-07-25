function I = bwjump(image)
[m,n] = size(image);
I_t = image;
for i = 1:m
    count=0;jump=0;temp=0;
    for j=1:n  
        if I_t(i,j)==1  
            temp=1;  
        else  
            temp=0;  
        end  
        if temp==jump  
            count=count;  
        else  
            count=count+1;  
        end  
        jump=temp;  
    end  
    if count<14  
        I_t(i,:)=0;  
    end  
end 
I = I_t;
end

