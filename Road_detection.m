function [counts,binLocations] = Road_detection 

A = imread('VC_P1_7.JPG');

A = imresize(A,0.2);

B=rgb2gray(A);

%%%% Road Identification %%%%
%
% This function takes an image as input and detectes based in an histogram
% threshold region
%
% 1st it selects a given region 
% 2nd it performs a hough tranform to select lines
% 3rd it clusters the lines and defines some as roads

%% Histogram threshold separation

[Y_a,X_a,~] = size(B);

Total_pixels = Y_a*X_a;

n=32;

[counts,binLocations] = imhist(B,n);

threshlod_hist=70;

sum_pixels = counts(1)/Total_pixels*100;

bin_max=0;

i=2;

while bin_max ==0
    
    if sum_pixels < threshlod_hist
        sum_pixels=sum_pixels+(counts(i)/Total_pixels)*100;
    else
        bin_max=i;
    end
    i=i+1;
end
    
[L_end,C_end]=size(B);

Max_intensity=binLocations(bin_max,1);

for L = 1:L_end
    for Col = 1:C_end
        
        if B(L,Col)>=Max_intensity
            B(L,Col)=uint8(255);
            C(L,Col)=B(L,Col);
        else
            C(L,Col)=uint8(0);
        end
        
    end
end

s_open = strel('disk',4);

s_close = strel('disk',7);

C = imopen(C,s_open);

C = imclose(C,s_close);

[accum, axis_rho, axis_theta, lineseg, dbg_label] = Hough_Grd(C,1,0.0000000000000000000000005);

% figure
% subplot(2,3,1)
% imshow(A)
% subplot(2,3,2)
% imshow(B)
% subplot(2,3,3)
imshow(C)
DrawLines_2Ends(dbg_label)

end