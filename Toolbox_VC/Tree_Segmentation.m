function [Arvores_Final,Contador] = Tree_Segmentation(Verde,H_A,S_A,V_A)

stropen = strel('disk',1);
strclose = strel('disk',5);
strdilate = strel('disk',2);

[comp_m,larg_m] = size(Verde);

for i = 1:comp_m
    for j = 1:larg_m
        if V_A(i,j) >= 0.35 && S_A(i,j) >= 0.25 && Verde(i,j) == 1
            Arvores(i,j) = 1;
        else
            Arvores(i,j) = 0;
        end
    end
end
figure(3)
imshow(Arvores)
% Segmentação da zona verde

Arvores_Open = bwareaopen(Arvores,8);
figure(4)
imshow(Arvores_Open)

Arvores_Close = imclose(Arvores_Open,strclose);
figure(5)
imshow(Arvores_Close)

Arvores_Final = imdilate(Arvores_Close,strdilate);
figure(6)
imshow(Arvores_Final)

Connected = bwconncomp(Arvores_Final);

Contador = Connected.NumObjects;