function [Arvores_Final] = Tree_Segmentation(Verde)

stropen = strel('disk',1);
strclose = strel('disk',5);
strdilate = strel('disk',3);

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