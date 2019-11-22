function [Verde] = Colour_Segmentation

A = imread('VC_P1_7.JPG');

A = histeq(A);

A = rgb2hsv(A);

A = imresize(A,0.15);

H_A = A(:,:,1);
S_A = A(:,:,2);
V_A = A(:,:,3);

delta_h = 0.10;
%Separar por cores: Amarelo, Azul, Verde
% H azul = 2/3; amarelo = 1/6; verde = 1/3

[comp_m,larg_m] = size(H_A);
Azul = zeros(comp_m,larg_m);
Verde = zeros(comp_m,larg_m);
Amarelo = zeros(comp_m,larg_m);
for i = 1:comp_m
    for j = 1:larg_m        
        if H_A(i,j) <= 2/3 + delta_h & H_A(i,j) >= 2/3 - delta_h
            Azul(i,j) = 1;
        else
            Azul(i,j) = 0;
        end
        
        if H_A(i,j) <= 1/3 + delta_h && H_A(i,j) >= 1/3 - delta_h
            Verde(i,j) = 1;
        else
            Verde(i,j) = 0;
        end
        % Tentar que amarelo não apareça
        if H_A(i,j) <= 1/6 + delta_h && H_A(i,j) >= 1/6 - delta_h
            Amarelo(i,j) = 1;
        else
            Amarelo(i,j) = 0;
        end
    end
end


figure(1)
subplot(1,3,1)
imshow(Azul)
title('Azul')
subplot(1,3,2)
imshow(Verde)
title('Verde')
subplot(1,3,3)
imshow(Amarelo)
title('Amarelo')
            
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
% 
% Verde_final = bwareaopen(Verde_Close,100);
% figure(5)
% imshow(Verde_final)
