%% Script to test diferent function for toolbox


A = imread('VC_P1_1.JPG');

number_spixel = 5000; % number of superpixel comand

Sigma=2;

B = imgaussfilt(A,Sigma);

[C] = SLIC(number_spixel,B);

level = 0.53; % Treeshold of BW

outputImage = im2bw(C,level);

imshow(outputImage,'InitialMagnification',13)


