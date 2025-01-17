function [B,C,D,Final] = Water_Segmentation (A)

Final=A;

A = histeq(A);

A = SLIC(45000,A);

A = rgb2hsv(A);

H_A = A(:,:,1);
S_A = A(:,:,2);
V_A = A(:,:,3);

[comp_m,larg_m] = size(H_A);

B = zeros(comp_m,larg_m);

for i = 1:comp_m
    for j = 1:larg_m
        if H_A(i,j) >= (1/2) - 0.2 && H_A(i,j) <= (1/2) + 0.15
            B(i,j) = 1;
        else
            B(i,j) = 0;
        end
    end
end

for p = 1:comp_m
    for k = 1:larg_m
        if  V_A(p,k) <= 0.70 && S_A(p,k) >= 0.05 && B(p,k) == 1
            B(p,k) = 1;
        else
            B(p,k) = 0;
        end
    end
end

strwateropen1 = strel('disk',2);   
strwateropen2 = 1200;
strwaterclose = strel('octagon',9);
strdilate = strel('disk',15);

C = imopen(B,strwateropen1);
C = bwareaopen(B,strwateropen2);
D = imclose(C, strwaterclose);
D = imdilate(D,strdilate); 

[l,c] = size(D);

for i = 1 : l
   for j = 1 : c
   
       if D(i,j)==1 
          
           Final(i,j,1)=uint8(176);
           Final(i,j,2)=uint8(240);
           Final(i,j,3)=uint8(230);
           
       end
       
   end
end


end