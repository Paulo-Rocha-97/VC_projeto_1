%% Script to test diferent function for toolbox

close all

A = imread('VC_P1_1.JPG');

B = histeq(A);

C = rgb2gray(B);

D = edge(C,'canny');

D = uint8(255*D);

D = cat(3,D,D,D);

number_spixel = 100000; % number of superpixel comand

[E] = SLIC(number_spixel,D);

E = histeq(E);

%number_spixel = 5000; % number of superpixel comand

% [C] = SLIC(number_spixel,B);
% 
% level = 0.80; 
% 
% D = im2bw(C,level);
% 
% s_open = strel('disk',40);
% 
% s_close = strel('disk',90);
% 
% s_dil=strel('disk',2);
% 
% E = imopen(E,s_open);
% 
% F = imclose(E,s_close);
% 
% F = imdilate(F,s_dil);

figure
subplot(2,3,1)
imshow(A)
subplot(2,3,2)
imshow(B)
subplot(2,3,3)
imshow(C)
subplot(2,3,4)
imshow(D)
subplot(2,3,5)
imshow(E)
subplot(2,3,6)
imshow(F)





