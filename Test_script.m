%% Script to test diferent function for toolbox

close all
clear all
clc

A = imread('VC_P1_1.JPG');

A = imresize(A,0.1);

% B = histeq(A);
% 
% C = Highboost(B, 10)
% 
% C = rgb2gray(C);
% 
% D = edge(C,'canny');


%this matlab program will only detect vertical lines in an image

A = imread('VC_P1_1.JPG'); %This will upload the image building

B = rgb2gray(A);

tol = 5;%define a tolerance in the angle to account for noise or edge
        % that may look vertical but when the angle is computed
        %it may not appear to be
[~,angle] = imgradient(B);
out = (angle >= 180 - tol | angle <= -180 + tol);
%this part will filter the line
C = bwareaopen(out, 50);


% D = uint8(255*D);
% 
% D = cat(3,D,D,D);

% number_spixel = 10000; % number of superpixel comand
% 
% [E] = SLIC(number_spixel,D);
% 
% E = histeq(E);

% s_open = strel('disk',40);
% 
% s_close = strel('disk',90);
% 
% s_dil=strel('disk',2);
% 
% F = imclose(E,s_close);
% 
% F = imdilate(F,s_dil);

figure
subplot(1,2,1)
imshow(A)
subplot(1,2,2)
imshow(B)

figure
imshow(C)
% subplot(2,3,4)
% imshow(D)
% subplot(2,3,5)
% imshow(E)
% subplot(2,3,6)
% imshow(F)





