A = imread('VC_P1_5.JPG');

A = histeq(A);

A = rgb2hsv(A);

A = imresize(A,0.15);

H_A = A(:,:,1);
S_A = A(:,:,2);
V_A = A(:,:,3);

delta_x = 0.10;
%Separar por cores: Amarelo, Azul, Verde
% H azul = 2/3; amarelo = 1/6; verde = 1/3

[comp_m,larg_m] = size(H_A);
Azul = zeros(comp_m,larg_m);
Verde = zeros(comp_m,larg_m);
Amarelo = zeros(comp_m,larg_m);
for i = 1:comp_m
    for j = 1:larg_m        
        if H_A(i,j) <= 2/3 + delta_x & H_A(i,j) >= 2/3 - delta_x
            Azul(i,j) = 1;
        else
            Azul(i,j) = 0;
        end
        
        if H_A(i,j) <= 1/3 + delta_x & H_A(i,j) >= 1/3 - delta_x
            Verde(i,j) = 1;
        else
            Verde(i,j) = 0;
        end
        % Tentar que amarelo n�o apare�a
        if H_A(i,j) <= 1/6 + delta_x & H_A(i,j) >= 1/6 - delta_x
            Amarelo(i,j) = 1;
        else
            Amarelo(i,j) = 0;
        end
    end
end


figure(1)
subplot(3,3,1)
imshow(Azul)
title('Azul')
subplot(3,3,2)
imshow(Verde)
title('Verde')
subplot(3,3,3)
imshow(Amarelo)
title('Amarelo')
            
stropen = strel('disk',10);
strclose = strel('octagon',9);

%Segmenta��o da zona verde
% Verde_Open = imopen(Verde,stropen);
% figure(3)
% imshow(Verde_Open)
% 
% Verde_Close = imclose(Verde_Open,strclose);
% figure(4)
% imshow(Verde_Close)
% 
% Verde_final = bwareaopen(Verde_Close,100);
% figure(5)
% imshow(Verde_final)
