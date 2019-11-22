function [A,B,C,D,E]=Road_detection_v2(tol, filtro_open,threshold)




% this function attempts to select specific angle lines edges

% INPUT : tol - tolerancia de valores de angulos
%         angulo - desejado
%         filtro - numero de pixeis minimo para ser objeto

close all
clc

A = imread('VC_P1_7.JPG');

A = imresize(A,0.15);

A = histeq(A);

B = rgb2gray(A);

[Gx,Gy] = imgradientxy(B);

figure

imshowpair(Gx,Gy,'montage');

[Gmag,Gdir] = imgradient(Gx,Gy);

[ Height , Width ] = size(B);

E=zeros(Height,Width);

for a= 1 : 20 : 181
    
    ang = a-1;
    
    for i = 1:Height
        for j = 1:Width
            
            if Gdir(i,j) > ang - tol && Gdir(i,j) < ang + tol && Gmag(i,j)> threshold
                C(i,j)=uint8(255);
            else
                C(i,j)= uint8(0);
            end
            
        end
    end
    
    
    
     S_close = strel('disk',1);
     
     C = imclose(C, S_close);
        
    D = bwareaopen(C, filtro_open);
    
    for i = 1:Height
        for j = 1:Width
            
            if D(i,j) ==1 || E(i,j)==255
                E(i,j)=uint8(255);
            else
                E(i,j)= uint8(0);
            end
        end
    end

end


se=strel('disk', 3);

E = imclose(E,se);

E = bwareaopen(E,100);

figure
imshow(E)

%% Hough transform

[H,T,R] = hough(E);

peaks = houghpeaks(H,50);

lines = houghlines(E,T,R,peaks);

%Plot lines 

figure  
imshow(A), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end


end