function I = midfilter(noise_image)

intImage = integralImage(noise_image);
avgH = integralKernel([1 1 3 3], 1/9);
avg_image = integralFilter(intImage, avgH);
I = uint8(avg_image);

end
