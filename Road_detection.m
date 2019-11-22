function [A,B,C] = Road_detection(threshlod_hist)

close all

A = imread('VC_P1_6.JPG');

A = imresize(A,0.15);

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

sum_pixels = counts(1)/Total_pixels*100;

bin_max=0;

i=1;

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

s_open = strel('disk',3);

s_close = strel('disk',8);

C = imopen(C,s_open);

C = imclose(C,s_close);

%% Hough transform 

[H,T,R] = hough(C);

peaks = houghpeaks(H,50);

lines = houghlines(C,T,R,peaks);


%% Plot results

% figure
% 
% imshow(C)
% hold on
% max_len = 0;
% 
% for k = 1:length(lines)
%     
%    xy = [lines(k).point1; lines(k).point2];
%    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% 
%    % Plot beginnings and ends of lines
%    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
% 
%    % Determine the endpoints of the longest line segment
%    len = norm(lines(k).point1 - lines(k).point2);
%    if ( len > max_len)
%       max_len = len;
%       xy_long = xy;
%    end
%    
% end

figure
imshow(A)
figure
imshow(C)

end