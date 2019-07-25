%This program is used to pre-process the image

processing_image = rgb2gray(situation_result); %get gray image
resize_image = imresize(processing_image,[400 NaN]);
%figure(3), imshow(processing_image);

%filter the noise

%add median filter
%filter_image = medfilt2(processing_image,[7,7]);
%filter_image = wiener2(processing_image,[5 5]);
%average filter
intImage = integralImage(resize_image);
avgH = integralKernel([1 1 3 3], 1/9);
avg_image = integralFilter(intImage, avgH);
filter_image = uint8(avg_image);
figure(4),imshow(filter_image);

%hisgram
%[x,y]=size(filter_image);                            %测量图像尺寸参数  
%GP=zeros(1,256);                           %预创建存放灰度出现概率的向量  
%for k=0:255  
    %GP(k+1)=length(find(filter_image==k))/(x*y);    %计算每级灰度出现的概率，将其存入GP中相应位置  
%end 
%bar(0:255,GP,'g');

%binary image strenth the character
fmax1=double(max(max(filter_image)));%get the max value
fmin1=double(min(min(filter_image)));%get the min value
Threshold=((fmax1-fmin1)*2/3+fmin1)/255;%get the threshold value     
binary_image=im2bw(filter_image,Threshold);%transfer to binary image
binary_image_double = double(binary_image);
figure(5),imshow(binary_image_double);

%rotation code

edge_image = edge(binary_image_double,'canny');%canny edge detection
figure(6),imshow(edge_image);
%hough transfer
[H,T,R]=hough(edge_image);
figure(7),imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'),ylabel('\rho');
axis on, axis normal,hold on;
%get the peaks
P=houghpeaks(H,4,'threshold',ceil(0.3*max(H(:))));
x=T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');
%find out the lines
lines=houghlines(edge_image,T,R,P,'FillGap',50,'MinLength',7);
figure(8),imshow(edge_image);
max_len = 0;
hold on;
%draw lines
for k=1:length(lines)
xy=[lines(k).point1;lines(k).point2];%get the line
plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');%start point
plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');%end point
len=norm(lines(k).point1-lines(k).point2);%calculate length
Len(k)=len;
if (len>max_len)%get the max length line
max_len=len;
xy_long=xy;
end
end
%get the longest line
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');
%get the slope
K1=-((xy_long(2,2)-xy_long(1,2))/(xy_long(2,1)-xy_long(1,1)))
angle=atan(K1)*180/pi;
forward_image = imrotate(binary_image,-angle,'bilinear');% turn back
figure(9),imshow(forward_image);
%se=strel('disk',2);
%forward_image2 = imopen(forward_image,se);
%figure(10),imshow(forward_image2);

preprocess_result = forward_image;

