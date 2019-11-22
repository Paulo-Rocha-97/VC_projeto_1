function [B,C,D,E,Final] = Sand_Segmentation (A)

Final=A;

A = SLIC(45000,A);

A = rgb2hsv(A);

H_A = A(:,:,1);
S_A = A(:,:,2);
V_A = A(:,:,3);

[comp_m,larg_m] = size(H_A);

B = zeros(comp_m,larg_m);
for i = 1:comp_m
    for j = 1:larg_m
        if V_A(i,j) >= 0.6 - 0.15 && V_A(i,j) <= 0.6 + 0.15
            B(i,j) = 1;
        else
            B(i,j) = 0;
        end
    end
end

 for k = 1:comp_m
     for l = 1:larg_m
         if H_A(k,l) >= (1/6) - 0.15 && S_A(k,l) <= (1/6) + 0.10 && B(k,l)==1
             B(k,l) = 1;
         else
             B(k,l) = 0;
         end
     end
 end
 
 for j = 1:comp_m
     for t = 1:larg_m
         if S_A(j,t) <= 0.25 && B(j,t) == 1
             B(j,t) = 1;
         else
             B(j,t) = 0;
         end
     end
 end
% 
%Segmentação da areia

strareiaclose = strel('octagon',12);
strareiaopen = strel('disk',3);
  
C = imopen(B,strareiaopen);
D = imclose(C,strareiaclose);
E = bwareaopen(D,500);

[l,c] = size(E);

for i = 1 : l
   for j = 1 : c
   
       if E(i,j)==1 
          
           Final(i,j,1)=uint8(240);
           Final(i,j,2)=uint8(230);
           Final(i,j,3)=uint8(140);
           
       end
       
   end
end

end
