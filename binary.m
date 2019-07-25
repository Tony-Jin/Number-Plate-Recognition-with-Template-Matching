function I = binary(gray_image)

fmax1=double(max(max(gray_image)));%get the max value
fmin1=double(min(min(gray_image)));%get the min value
Threshold=((fmax1-fmin1)*2/3+fmin1)/255;%get the threshold value     
I=im2bw(gray_image,Threshold);%transfer to binary image

end
