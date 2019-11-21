A = imread('VC_P1_6.JPG');

A = histeq(A);

A = SLIC(45000,A);

A = rgb2hsv(A);

A = imresize(A,0.15);

H_A = A(:,:,1);
S_A = A(:,:,2);
V_A = A(:,:,3);

[comp_m,larg_m] = size(H_A);

Areia = zeros(comp_m,larg_m);
for i = 1:comp_m
    for j = 1:larg_m
        if V_A(i,j) >= 0.95 - 0.10 & V_A(i,j) <= 0.95 + 0.10
            Areia(i,j) = 1;
        else
            Areia(i,j) = 0;
        end
    end
end

 for k = 1:comp_m
     for l = 1:larg_m
         if H_A(k,l) >= (1/6) - 0.15 && S_A(k,l) <= (1/6) + 0.10 && Areia(k,l)==1
             Areia(k,l) = 1;
         else
             Areia(k,l) = 0;
         end
     end
 end
 
 for j = 1:comp_m
     for t = 1:larg_m
         if S_A(j,t) <= 0.10 && Areia(j,t) == 1
             Areia(j,t) = 1;
         else
             Areia(j,t) = 0;
         end
     end
 end
 figure(2)
 imshow(Areia)
% 
%Segmentação da areia

strareiaclose = strel('octagon',12);
strareiaopen = strel('disk',2);
  
Areia_Open = imopen(Areia,strareiaopen);
Areia_Close = imclose(Areia_Open,strareiaclose);
Areia_Final = bwareaopen(Areia_Close,200);
% 
figure(6)
imshow(Areia_Final)