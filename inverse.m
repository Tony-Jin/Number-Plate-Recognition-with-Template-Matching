function I = inverse(binary_image)

[m,n]=size(binary_image);       
I=ones(m,n)-binary_image;

end
