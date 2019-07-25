%This program is used to pre-process the image

processing_image = rgb2gray(situation_result); %get gray image
resize_image = imresize(processing_image,[400 NaN]);
[m,n] = size(resize_image);
%figure(3), imshow(processing_image);

%add filter
filter_image = midfilter(resize_image);
figure(4),imshow(filter_image);

%binary image 
binary_image = binary(filter_image);
binary_image_double = double(binary_image);
figure(5),imshow(binary_image_double);

%rotate image
%inverse binary image
Image_inv = inverse(binary_image);
%figure(6),imshow(Image_inv);

forward_image = radon_trans(Image_inv);
figure(7),imshow(forward_image);

se=strel('rectangle',[2 5]);
close_image=imclose(forward_image,se); 
se1=strel('disk',1);
open_image=imopen(close_image,se1);  
figure(8),imshow(open_image);
%black and white jump
borderless_image = bwjump(open_image);
figure(9),imshow(borderless_image);

se2=strel('rectangle',[1 30]);
process_image = imopen(borderless_image,se2);

figure(10),imshow(process_image);
