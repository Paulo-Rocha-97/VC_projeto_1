function [B,C,D,E,F,Final,Contador] = Tree_Segmentation(A)

Final=A;

[B,~,S_A,V_A] = Colour_Segmentation (A);

strclose = strel('disk',5);
strdilate = strel('disk',2);

[comp_m,larg_m] = size(B);

for i = 1:comp_m
    for j = 1:larg_m
        if V_A(i,j) >= 0.35 && S_A(i,j) >= 0.25 && B(i,j) == 1
            C(i,j) = 1;
        else
            C(i,j) = 0;
        end
    end
end
% figure(3)
% imshow(C)

% Segmentação da zona verde

D = bwareaopen(C,8);
% figure(4)
% imshow(D)

E = imclose(D,strclose);
% figure(5)
% imshow(E)

F = imdilate(E,strdilate);
% figure(6)
% imshow(F)

[H,C]= size(F);

for i = 1 :H
   for j = 1 : C
   
       if F(i,j)==1 
          
           Final(i,j,1)=uint8(66);
           Final(i,j,2)=uint8(235);
           Final(i,j,3)=uint8(40);
           
       end
       
   end
end


Connected = bwconncomp(F);

Contador = Connected.NumObjects;