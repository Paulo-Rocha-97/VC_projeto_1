function [Gdir,B,B_,C_col,C_,D,E,F,lines,line_bw,Final] =  Road_detection_v3 (A)

Final=A;

%% Remove areas

[~,~,~,Sand,~] = Sand_Segmentation (A);
[~,~,Water,~] = Water_Segmentation (A);

[L_rows,C_col,~]=size(A);

Remove=zeros(C_col,L_rows);

for i=1:L_rows
    for j=1:C_col
        
        if Sand(i,j)==1 && Water(i,j)==1
            Remove(i,j)=1;
        else
            Remove(i,j)=Sand(i,j)+Water(i,j);
        end
    end
end

se_dil = strel('disk',20);

Remove = imdilate(Remove,se_dil);


%%
B = rgb2gray(A);

B_ = B;


%% Autothreshold selection based on Histogram 

[Y_a,X_a,~] = size(B);

Total_pixels = Y_a*X_a;

n = 32;

[counts,binLocations] = imhist(B,n);

threshlod_hist = 65;

sum_pixels = counts(1)/Total_pixels*100;

bin_max = 0;

i = 1;

while bin_max ==0
    
    if sum_pixels < threshlod_hist
        
        sum_pixels=sum_pixels+(counts(i)/Total_pixels)*100;
    else
        
        bin_max=i;
    end
    i=i+1;
end
    
Max_intensity=binLocations(bin_max,1);

for i = 1:L_rows
    for j = 1:C_col
        
        if B_(i,j)>=Max_intensity
            B_(i,j)=uint8(255);
            C_(i,j)=B_(i,j);
        else
            C_(i,j)=uint8(0);
        end
        
    end
end

s_open = strel('disk',4);

s_close = strel('disk',4);

C_ = imopen(C_,s_open);

C_ = imclose(C_,s_close);

%% Gradient based selection

tol =30;

filtro_open = 160;

threshold = 30;

A = histeq(A);

[Gx,Gy] = imgradientxy(B);

[Gmag,Gdir] = imgradient(Gx,Gy);

E=zeros(L_rows,C_col);

C=zeros(L_rows,C_col);

for a= 1 : 20 : 181
    
    ang = a-1;
    
    for i = 1:L_rows
        for j = 1:C_col
            
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
    
    for i = 1:L_rows
        for j = 1:C_col
            
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

%% Mixed of both methods and removal of sand and water area

F = zeros(L_rows,C_col);

for i = 1:L_rows
   
    for j=1:C_col
        
        if C_(i,j) == 255 && E(i,j)==1
            
            F(i,j) = uint8(255);
 
        else
            
            F(i,j) = uint8(0);
            
        end
        
        if Remove(i,j)==1
            
            F(i,j) = uint8(0);
        
        end
    end

end

S_close_F = strel('octagon',6);

F = imclose(F,S_close_F);

SE = strel('octagon',3);

F = imdilate(F,SE);

%% Hough Transform

[H,T,R] = hough(F);

peaks = houghpeaks(H,50);

lines = houghlines(F,T,R,peaks,'FillGap',20,'MinLength',40);

[~,linenumber]=size(lines);

line=zeros(linenumber,6);

for i=1: linenumber
   
    %point 1 
    line(i,1)=lines(1,i).point1(1,1); % X_1
    line(i,2)=lines(1,i).point1(1,2); % Y_1
    % point 2
    line(i,3)=lines(1,i).point2(1,1); % X_2
    line(i,4)=lines(1,i).point2(1,2); % Y_2
    % parameters
    line(i,5)= (line(i,2) - line(i,4)) / (line(i,1) - line(i,3)); % m  
    line(i,6)= line(i,2) - line(i,5) * line(i,1); % b
end

line_bw=zeros(L_rows,C_col);

for r = 1: linenumber
    for j =1:C_col
         if line(r,1) <  line(r,3)
            menor_x = 1;
            maior_x = 3;
        else
            menor_x = 3;
            maior_x = 1;
        end
        
        if j>=line(r,menor_x) && j<=line(r,maior_x)
            
            Y = round( line(r,5)*j + line(r,6) );
            
            line_bw(Y,j) = 1;
            
        end
    end
end

se_dil = strel('disk',4);

line_bw = imdilate(line_bw,se_dil);

se_close = strel('disk',30);

line_bw = imclose(line_bw,se_close);

se_open = strel('disk',3);

line_bw = imopen(line_bw,se_open);

for i = 1 : L_rows
   for j = 1 : C_col
   
       if line_bw(i,j)==1 
          
           Final(i,j,1)=uint8(119);
           Final(i,j,2)=uint8(136);
           Final(i,j,3)=uint8(153);
           
       end
       
   end
end

end


