clear all;close all;clc;
%This program is used to change the ideal extracted image to different situation
original_image = imread('view1.jpg');%backplat1.png,backplat2.jpg and backplat3.jpg

%add angle
rotate_image = imrotate(original_image,80,'bilinear');
figure(1),imshow(rotate_image);

%add noise
noise_image = imnoise(original_image,'gaussian',0.5);% from 0 to 1 
%noise_image = imnoise(rotate_image,'salt & pepper',0.35);% 0.35 max
figure(2),imshow(noise_image);

situation_result = noise_image;

