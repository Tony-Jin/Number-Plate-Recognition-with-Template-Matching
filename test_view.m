image = imread('backplat6.jpg');
%image = rgb2gray(I);
az = 0;
el = 10;

h=figure(1);
alphar=im2double(image);
imshow(alphar);
view(az, el);


saveas(h,'view_t','jpg');
%bc=imread('picture2.jpg');

%h2=figure(2);
%imshow(bc);
%view(-180-az, 90);
%saveas(h2,'picture3','jpg');