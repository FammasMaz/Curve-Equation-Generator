RGB = imread(strcat(destinationFolder, '1.png')); %Reads the first image
I = rgb2gray(RGB); %Converts the image into grayscale
threshold = 0.2; %The Threshold for converting the pixels into either white or black
BW = im2bw(I, threshold); %Converts the image into binary Black and White

imtool(BW); %Displays the image

fprintf('The best threshold value is %f\n\n', threshold)